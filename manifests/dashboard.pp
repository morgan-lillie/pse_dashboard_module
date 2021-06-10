class pse_dashboard_module::dashboard{


file {
  ensure => directory
  path => ~/dash
}

vcsrepo {~/dash/smashing_dash_pse
  ensure    => present,
  provider  => git,
  source    => 'https://github.com/chrislorro/smashing_dash_pse.git',
  }
}

