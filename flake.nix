{
  description = "Canonical authored Spirit Ethos roots";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/35d3407a3816f3b341d8cf1d60abaf2b7b8166ac";
    flake-utils.url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
    core-ethos.url = "github:LiGoldragon/core-ethos/29237c33798db908bbfe10ef0cffe2c6a28be508";
    core-nomos.url = "github:LiGoldragon/core-nomos/96b156c5f578f82e07c1640e15ef04338a00b65e";
    core-logos.url = "github:LiGoldragon/core-logos/c7bd55bb29f7c0e10212571d2b4a2f69aae4b35b";
    rust-logos.url = "github:LiGoldragon/rust-logos/f3e4b7846ed032bc644f9a5b10a4ca8f3fb4c593";
    language-engine-witness.url = "github:LiGoldragon/language-engine-witness/efe8ed3d5ea53f280b93cc1f2f131d92ef781832";
    signal-spirit-source = {
      url = "github:LiGoldragon/signal-spirit/b8107601cd47ded10ea897828f8e5650d3949209";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, signal-spirit-source, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        checks.source-roots = pkgs.runCommand "spirit-ethos-source-roots" { } ''
          ${pkgs.gnugrep}/bin/grep -Fx 'Interface.1' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx 'Nexus.1' ${./nexus.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx 'Sema.1' ${./sema.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    Entry.{Domains Kind Description Importance}' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    Domains.Vector<Domain>' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    Description.String' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    RecordIdentifier.String' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    Importance.Magnitude' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    Magnitude.[Zero Minimum VeryLow Low Medium High VeryHigh Maximum]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    Kind.[Decision Principle Correction Clarification Constraint]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '  Magnitude [Zero Minimum VeryLow Low Medium High VeryHigh Maximum]' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  Domains (Vector Domain)' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  Description String' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  RecordIdentifier String' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  Importance Magnitude' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  Kind [Decision Principle Correction Clarification Constraint]' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  Entry { Domains Kind Description Importance }' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '    Observer.Stream.(Query IntentEvent)' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    DomainMatch.[Any Partial.DomainScopes Full.DomainScopes]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    KeywordMatch.[Any AnyKeyword.Keywords AllKeywords.Keywords]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    TextMatch.[Any ContainsText.SearchText]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    SelectedKind.Optional<Kind>' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    ImportanceSelection.[Any ExactImportance.Importance AtMostImportance.Importance AtLeastImportance.Importance]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    Query.{DomainMatch KeywordMatch TextMatch SelectedKind ImportanceSelection}' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '  DomainMatch [Any (Partial) (Full)]' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  Partial DomainScopes' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  Full DomainScopes' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  Keyword String' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  Keywords (Vector Keyword)' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  KeywordMatch [Any (AnyKeyword) (AllKeywords)]' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  AnyKeyword Keywords' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  AllKeywords Keywords' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  SearchText String' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  TextMatch [Any (ContainsText)]' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  ContainsText SearchText' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  SelectedKind (Optional Kind)' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  ImportanceSelection [Any (ExactImportance) (AtMostImportance) (AtLeastImportance)]' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  ExactImportance Importance' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  AtMostImportance Importance' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  AtLeastImportance Importance' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '  Query { DomainMatch KeywordMatch TextMatch SelectedKind ImportanceSelection }' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx '    StoredRecord.{RecordIdentifier Entry}' ${./sema.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    Migration.{SourceSchemaVersion MigratedRecordCount}' ${./sema.ethos}
          ${pkgs.gawk}/bin/awk '
            /^  \[/ { lists += 1 }
            /Observer\.Stream\.\(Query IntentEvent\)/ { transformer_lists = lists }
            END { exit !(lists == 4 && transformer_lists == 4) }
          ' ${./interface.ethos}
          ! ${pkgs.gnugrep}/bin/grep -E 'Certainty|Privacy|Referent|Candidate|Name\.\(|\||Text' ${./interface.ethos} ${./nexus.ethos} ${./sema.ethos}
          ! ${pkgs.gnugrep}/bin/grep -E '^(Interface|Nexus|Sema)\.14$' ${./interface.ethos} ${./nexus.ethos} ${./sema.ethos}
          mkdir -p $out
        '';
        checks.sealed-allocation = pkgs.runCommand "spirit-ethos-sealed-allocation" {
          nativeBuildInputs = [ pkgs.gawk pkgs.coreutils pkgs.diffutils pkgs.jq ];
        } ''
          ${pkgs.jq}/bin/jq -e '
            (.names | length == 143)
            and ([.names[].spelling] | unique | length == 143)
            and ([.names[].chain[0]] | unique | length == 143)
            and (all(.names[]; .root == "universal" and (.chain | length == 1) and .chain[0] >= 0 and .chain[0] <= 142))
            and (.grammar.interface_document == [34])
            and (.grammar.nexus_document == [40])
            and (.grammar.sema_document == [42])
            and (.rust_grammar.newtype_item == [4])
            and (.rust_grammar.enumeration_item == [3])
            and (.rust_grammar.struct_keyword == [10])
            and (.rust_grammar.enum_keyword == [8])
          ' ${./batch-config.json} > /dev/null
          ! ${pkgs.gnugrep}/bin/grep -E '"chain": \[(1000|1001|1002|1003|1004|1005|1006|1007|1008|1009)' ${./batch-config.json}
          ${pkgs.gawk}/bin/awk '$1 == "universal" || $1 == "universal-reference" { print $2 " " $3 }' ${./allocation-manifest.nota} > manifest-names
          ${pkgs.jq}/bin/jq -r '.names[] | "\(.spelling) \(.chain[0])"' ${./batch-config.json} > configured-names
          test "$(${pkgs.coreutils}/bin/wc -l < manifest-names)" = 143
          ${pkgs.diffutils}/bin/cmp manifest-names configured-names
          ${pkgs.gnugrep}/bin/grep -Fx 'request-digest 7240a488adad7438b41ae881436a631c29312431a66aef0a7bb1f21eff6b4535' ${./allocation-receipt.nota}
          ${pkgs.gnugrep}/bin/grep -Fx 'database-marker commit-sequence=2 snapshot=2' ${./allocation-receipt.nota}
          ${pkgs.gnugrep}/bin/grep -Fx 'request-digest 6003e269dc6fcffb1bfca21f0f81d436d60ed141af4fc668643c13f70c0727bc' ${./allocation-receipt.nota}
          ${pkgs.gnugrep}/bin/grep -Fx 'database-marker commit-sequence=3 snapshot=3' ${./allocation-receipt.nota}
          ${pkgs.gnugrep}/bin/grep -Fx 'rust struct 10' ${./allocation-manifest.nota}
          ${pkgs.gnugrep}/bin/grep -Fx 'rust enum 8' ${./allocation-manifest.nota}
          mkdir -p $out
        '';
      });
}
