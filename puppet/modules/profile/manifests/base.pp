class profile::base {
  yumrepo { "epel-${::operatingsystemmajrelease}-${::architecture}":
    mirrorlist  => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch',
    enabled     => '1',
    gpgcheck    => '0',
    descr       => "EPEL${::operatingsystemmajrelease}"
  }
  package {'git':
    ensure => installed,
  }
  Yumrepo <| |> -> Package <| |>
}
