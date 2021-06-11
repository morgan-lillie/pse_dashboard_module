#
class pse_dashboard_module::dashboard{

  include rbenv
  include nodejs

  rbenv::plugin { 'rbenv/ruby-build': }
  rbenv::build { '3.0.1':
    global => true,
  }

  file { '/home/centos/dash':
    ensure  => 'directory',
  }

  vcsrepo {'/home/centos/dash/smashing_dash_pse':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/chrislorro/smashing_dash_pse.git',
  }

  exec { 'install_bundler_gems':
    command   => '/usr/local/rbenv/shims/bundle install',
    subscribe =>  Vcsrepo['/home/centos/dash/smashing_dash_pse'],
    cwd       => '/home/centos/dash/smashing_dash_pse',
  }

  # service { 'sshd':
  #   ensure    => running,
  #   enable    => true,
  #   subscribe => File['/etc/ssh/sshd_config'],
  # }

  file { 'psesmashdash.service':
    path    => '/etc/systemd/system/psesmashdash',
    content => '[Unit]
Description=runs the pse dashboard

[Service]
User=root
WorkingDirectory=/home/centos/dash/smashing_dash_pse
ExecStart=/usr/local/rbenv/shims/bundle exec smashing start
Restart=always

[Install]
WantedBy=multi-user.target',

  }

  exec { 'add service':
    subscribe => File['psesmashdash.service'],
    command   => '/bin/sudo systemctl daemon-reload',
  }

  service { 'psesmashdash':
    ensure => 'running'
  }

}

