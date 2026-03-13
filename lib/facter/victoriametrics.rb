# frozen_string_literal: true

if File.exist? "/opt/victoriametrics/bin" then
  Facter.add(:victoriametrics) do
    setcode do
      victoriametrics = {}
      # Get versions for all three victoriametrics cluster binaries
      [
        "vminsert",
        "vmselect",
        "vmstorage",
      ].each do |binary|
        version = Facter::Core::Execution.execute("/opt/victoriametrics/bin/#{binary}-prod -version", { on_fail: nil })
        victoriametrics[:"#{binary}_version"] = version.match(%r{v\d+\.\d+\.\d+}).to_s if version
      end
      victoriametrics
    end
  end
end
