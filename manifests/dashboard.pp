class pase_dashboard_module::dashboard (

vcsrepo {~/dash/smashing_dash_pse
  ensure    => present,
  provider  => git,
  source    => https://github.com/chrislorro/smashing_dash_pse.git
  }
)
