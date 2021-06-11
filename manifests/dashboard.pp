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

  file { 'psesmashdash':
    content => '[Unit]"\n"Description=<description about this service>\n\n[Service]\nUser=<user e.g. root>\nWorkingDirectory=<directory_of_script e.g. /root>\nExecStart=<script which needs to be executed>\nRestart=always\n\n[Install]\nWantedBy=multi-user.target',
    path    => '/home/psesmashdashtest',

  }

}

