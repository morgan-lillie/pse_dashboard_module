#
class pse_dashboard_module::dashboard{

  include rbenv
  rbenv::plugin { 'rbenv/ruby-build': }
  rbenv::build { '3.0.1':
    global => true,
  }
  rbenv::gem { 'bundler':
    ruby_version => '3.0.1',
  }

  file { '/home/centos/dash':
    ensure  => 'directory',
  }

  vcsrepo {'/home/centos/dash/smashing_dash_pse':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/chrislorro/smashing_dash_pse.git',
  }

}

