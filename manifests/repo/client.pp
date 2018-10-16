class spacewalk::repo::client (
  $client_repo_enabled  = '1',
  $client_repo_gpgcheck = '1',
  $client_repo_release  = '2.8',
  $client_repo_gpgkey   = "https://copr-be.cloud.fedoraproject.org/results/@spacewalkproject/spacewalk-${client_repo_release}-client/pubkey.gpg",


){

  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        'Fedora': {
          $repo = "https://copr-be.cloud.fedoraproject.org/results/@spacewalkproject/spacewalk-${client_repo_release}-client/fedora-${::operatingsystemmajrelease}-\$basearch"
        }
        'RedHat', 'CentOS': {
          $repo = "https://copr-be.cloud.fedoraproject.org/results/@spacewalkproject/spacewalk-${client_repo_release}-client/epel-${::operatingsystemmajrelease}-\$basearch"
        }
      }

      yumrepo {'spacewalk-client':
        enabled  => $client_repo_enabled,
        descr    => "Spacewalk Client ${client_repo_release} Repository",
        gpgcheck => $client_repo_gpgcheck,
        gpgkey   => $client_repo_gpgkey,
        baseurl =>  $repo,
      }
    }

    default: {
      fail("OS ${::operatingsystem} not supported")
    }
  }
}
