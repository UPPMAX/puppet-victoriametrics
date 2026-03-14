# frozen_string_literal: true

if File.exist? "/opt/victoriametrics/bin" then
  Facter.add(:victoriametrics) do
    setcode do
      victoriametrics = {}
      # Get versions for all victoriametrics binaries
      [
        # cluster tarball:
        "vminsert",
        "vmselect",
        "vmstorage",
        # vmutils tarball:
        "vmagent",
        "vmalert",
        "vmalert-tool",
        "vmauth",
        "vmbackup",
        "vmctl",
        "vmrestore",
      ].each do |binary|
        version = Facter::Core::Execution.execute("/opt/victoriametrics/bin/#{binary}-prod -version", { on_fail: nil })
        victoriametrics[:"#{binary}_version"] = version.match(%r{v\d+\.\d+\.\d+}).to_s if version
      end
      victoriametrics
    end
  end
end
