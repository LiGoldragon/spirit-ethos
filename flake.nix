{
  description = "Canonical authored Spirit Ethos roots";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/35d3407a3816f3b341d8cf1d60abaf2b7b8166ac";
    flake-utils.url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
    core-ethos.url = "github:LiGoldragon/core-ethos/29237c33798db908bbfe10ef0cffe2c6a28be508";
    core-nomos.url = "github:LiGoldragon/core-nomos/1580cac092885bfea6a8cd68d4e04b3a99eaf87d";
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
          ${pkgs.gnugrep}/bin/grep -Fx 'Entry.{Domains Kind Description Importance}' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '    Magnitude.[Zero Minimum VeryLow Low Medium High VeryHigh Maximum]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx '  Magnitude [Zero Minimum VeryLow Low Medium High VeryHigh Maximum]' ${signal-spirit-source}/schema/signal.schema
          ${pkgs.gnugrep}/bin/grep -Fx 'Observer.Stream.(Query IntentEvent)' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx 'DomainMatch.[Any Partial.DomainScopes Full.DomainScopes]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx 'KeywordMatch.[Any AnyKeyword.Keywords AllKeywords.Keywords]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx 'TextMatch.[Any ContainsText.SearchText]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx 'SelectedKind.Optional<Kind>' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx 'ImportanceSelection.[Any ExactImportance.Importance AtMostImportance.Importance AtLeastImportance.Importance]' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx 'Query.{DomainMatch KeywordMatch TextMatch SelectedKind ImportanceSelection}' ${./interface.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx 'StoredRecord.{RecordIdentifier Entry}' ${./sema.ethos}
          ${pkgs.gnugrep}/bin/grep -Fx 'Migration.{SourceSchemaVersion MigratedRecordCount}' ${./sema.ethos}
          ! ${pkgs.gnugrep}/bin/grep -E 'Certainty|Privacy|Referent|Candidate|Name\.\(|\||Text' ${./interface.ethos} ${./nexus.ethos} ${./sema.ethos}
          ! ${pkgs.gnugrep}/bin/grep -E '^(Interface|Nexus|Sema)\.14$' ${./interface.ethos} ${./nexus.ethos} ${./sema.ethos}
          mkdir -p $out
        '';
      });
}
