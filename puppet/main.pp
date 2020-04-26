$packages = [
  'apt-file',
  'binutils',
  'colordiff',
  'emacs-nox',
  'git',
  'graphviz',
  'htop',
  'kpcli',
  'make',
  'pv',
  'python3-pip',
  'ripgrep',
  'tree',
  'xstow',
  'zsh',
]

package { $packages:
  ensure => 'latest',
  provider => 'brew'
}

user { $::sudo_user:
  ensure => present,
  shell  => "/bin/zsh",
}

node  default{
class { 'golang':
  version   => '1.14.1',
  workspace => '/usr/local/src/go',
}}

ssh_keygen { $::sudo_user:
  bits => 4096
}
