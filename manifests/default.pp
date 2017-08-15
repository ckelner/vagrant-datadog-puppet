class { 'datadog_agent':
  api_key => $dd_api_key
}

class { 'datadog_agent::integrations::http_check':
  instances => [{
    'sitename'                     => 'google',
    'url'                          => 'https://www.google.com',
    'check_certificate_expiration' => true,
    'days_warning'                 => 30,
    'days_critical'                => 10,
    'tags'                         => ['kelnerhax', 'http_check:kelner']
  },
  {
    'sitename'                     => 'yahoo',
    'url'                          => 'https://yahoo.com/',
    'check_certificate_expiration' => true,
    'days_warning'                 => 30,
    'days_critical'                => 10,
    'tags'                         => ['kelnerhax', 'http_check:testing123']
  }]
}
