Facter.add(:passalgo) do
  confine :osfamily => "RedHat"
  setcode do
    algo = Facter::Core::Execution.exec("authconfig --test | grep hashing | awk '{print $5}'")
    case algo
    when /md5/
      'md5'
    when /sha256/
      'sha256'
    when /sha512/
       'sha512'
    when /descrypt/
       'crypt'
    when /bigcrypt/
       'crypt'
    else
       'unknown'
    end
  end
end

Facter.add(:passalgo) do
  confine :osfamily => "Solaris"
  setcode do
    algo = File.read('/etc/security/policy.conf').scan(/^CRYPT_DEFAULT=(.+)/)
    case algo[0][0].to_s
    when /1/
      'md5'
    when /2a/
      'blowfish'
    when /md5/
      'sunmd5'
    when /5/
      'sha256'
    when /6/
      'sha512'
    when /unix/
      'crypt'
    else
      'unknown'
    end
  end
end
