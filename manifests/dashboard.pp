class pse_dashboard_module::dashboard{


file { '/home/centos/dash':
    ensure => 'directory',

}

vcsrepo {'/home/centos/dash/smashing_dash_pse':
  ensure    => present,
  provider  => git,
  source    => 'https://github.com/chrislorro/smashing_dash_pse.git',
  }
}

