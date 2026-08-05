use serde_json::Value;
use sha2::{Digest, Sha256};

use nomos_engine::batch::{BatchConfiguration, OfflineBatchConfiguration};

const EVIDENCE: &str = include_str!("fixtures/signal-domain-v14-successor.evidence");
const LOCK: &str = include_str!("../Cargo.lock");
const PHYSICAL_SCHEMA_SOURCE_DIGEST: &str =
    "a29272a0d909a4bb4a6288e8aac265cae9e0485a90f14fc71f5f4b932669fe8e";
const COMPILED_SCHEMA_SOURCE_DIGEST: &str =
    "a7c2479449832c29aed8eae0c7fb20fa3393e531d762a9b9ececafc8b8b02f51";
const TRANSITIVE_TYPE_SET_DIGEST: &str =
    "49befecc0cba43444f84ac8db4e09b15ba39e8d8323e2d2966c3919f279be086";
const PROOF_DIGEST: &str = "ef4533d3243698920fd79a4c099485eb9bc61aa05933a02b94724a288e3832fb";
const PHYSICAL_REVISION: &str = "c24059de43614e6fb2128e47f959dc11748bd7e7";
const COMPILED_REVISION: &str = "fbc400bf5ed5e4c4d27ef4e76cb48fa4e5d53658";

fn digest(source: &str) -> String {
    format!("{:x}", Sha256::digest(source.as_bytes()))
}

fn current_to_physical_source(source: &str) -> String {
    source
        .replace("feature = \"dotos-text\"", "feature = \"nota-text\"")
        .replace(
            "dotos::{DotosDecodeError, DotosEncode, DotosSource}",
            "nota::{NotaDecodeError, NotaEncode, NotaSource}",
        )
        .replace("dotos::DotosDecode", "nota::NotaDecode")
        .replace("dotos::DotosEncode", "nota::NotaEncode")
        .replace("DotosDecodeError", "NotaDecodeError")
        .replace("DotosSource", "NotaSource")
        .replace("DotosEncode", "NotaEncode")
        .replace("to_dotos", "to_nota")
}

fn physical_to_current_source(source: &str) -> String {
    source
        .replace("feature = \"nota-text\"", "feature = \"dotos-text\"")
        .replace(
            "nota::{NotaDecodeError, NotaEncode, NotaSource}",
            "dotos::{DotosDecodeError, DotosEncode, DotosSource}",
        )
        .replace("nota::NotaDecode", "dotos::DotosDecode")
        .replace("nota::NotaEncode", "dotos::DotosEncode")
        .replace("NotaDecodeError", "DotosDecodeError")
        .replace("NotaSource", "DotosSource")
        .replace("NotaEncode", "DotosEncode")
        .replace("to_nota", "to_dotos")
}

fn generated_type_set(source: &str) -> String {
    let declarations = source
        .lines()
        .filter(|line| {
            line.starts_with("pub enum ")
                || line.starts_with("pub struct ")
                || line.starts_with("pub type ")
        })
        .collect::<Vec<_>>();
    format!("{}\n", declarations.join("\n"))
}

#[test]
fn current_signal_domain_is_the_sealed_exhaustive_v14_abi_successor() {
    BatchConfiguration::from_json(spirit_ethos::BATCH_CONFIGURATION)
        .expect("sealed ordinary batch configuration syntax")
        .prepare()
        .expect("sealed successor provenance is structurally complete");
    let configuration: Value = serde_json::from_str(spirit_ethos::BATCH_CONFIGURATION)
        .expect("sealed ordinary batch configuration JSON");
    let domain = configuration["rust_types"]
        .as_array()
        .expect("rust type mappings")
        .iter()
        .find(|mapping| mapping["spelling"] == "Domain")
        .expect("Domain mapping");
    let storage = &domain["external_storage"];
    let successor = &storage["successor"];
    assert_eq!(storage["revision"], COMPILED_REVISION);
    assert_eq!(successor["physical_owner"]["revision"], PHYSICAL_REVISION);
    assert_eq!(successor["compiled_owner"]["revision"], COMPILED_REVISION);
    assert_eq!(
        successor["type_identities"],
        serde_json::json!(["Domain", "DomainScopes"])
    );
    assert_eq!(successor["proof_digest"], PROOF_DIGEST);
    assert_eq!(
        successor["archive_abi"],
        serde_json::json!({
            "layout": true,
            "variant_order": true,
            "discriminants": true,
            "size": true,
            "alignment": true,
            "archive_bytes": true,
        })
    );

    let current = signal_domain::DOMAIN_RUST_SOURCE;
    assert_eq!(digest(current), COMPILED_SCHEMA_SOURCE_DIGEST);
    let physical = current_to_physical_source(current);
    assert_eq!(digest(&physical), PHYSICAL_SCHEMA_SOURCE_DIGEST);
    assert_eq!(physical_to_current_source(&physical), current);

    let declarations = generated_type_set(current);
    assert_eq!(declarations.lines().count(), 82);
    assert_eq!(digest(&declarations), TRANSITIVE_TYPE_SET_DIGEST);

    assert_eq!(LOCK.matches("name = \"signal-domain\"").count(), 1);
    assert!(LOCK.contains(COMPILED_REVISION));
    assert!(!LOCK.contains(PHYSICAL_REVISION));
    assert!(LOCK.contains("name = \"rkyv\"\nversion = \"0.8.17\""));

    let payload = format!(
        "{}\n",
        EVIDENCE
            .lines()
            .filter(|line| !line.starts_with("proof-digest "))
            .collect::<Vec<_>>()
            .join("\n")
    );
    assert_eq!(digest(&payload), PROOF_DIGEST);
    assert!(EVIDENCE.contains(&format!("proof-digest {PROOF_DIGEST}")));
    assert!(EVIDENCE.contains("type-identity Domain\n"));
    assert!(EVIDENCE.contains("type-identity DomainScopes\n"));
    assert!(EVIDENCE.contains("archive-abi-layout exact-generated-source\n"));
    assert!(EVIDENCE.contains("archive-abi-variant-order exact-generated-source\n"));
    assert!(EVIDENCE.contains("archive-abi-discriminants exact-generated-source\n"));
    assert!(EVIDENCE.contains("archive-abi-size exact-generated-source-and-rkyv-lock\n"));
    assert!(EVIDENCE.contains("archive-abi-alignment exact-generated-source-and-rkyv-lock\n"));
    assert!(EVIDENCE.contains("archive-abi-bytes exact-generated-source-and-rkyv-lock\n"));
}
