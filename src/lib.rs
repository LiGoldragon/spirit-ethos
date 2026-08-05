//! Sealed authored source roots for the generated Spirit contract family.
//!
//! Consumers read these constants at build time.  They never own a copied
//! schema or a hand-maintained projection of an Ethos root.

use std::path::{Path, PathBuf};

pub const INTERFACE: &str = include_str!("../interface.ethos");
pub const NEXUS: &str = include_str!("../nexus.ethos");
pub const SEMA: &str = include_str!("../sema.ethos");
pub const BATCH_CONFIGURATION: &str = include_str!("../batch-config.json");

pub fn source_root() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).to_path_buf()
}
