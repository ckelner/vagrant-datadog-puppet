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
  },
  # The following was written as an example to determine why days_warning and
  # days_critical is not being written to the dd-agent conf. What you'll note
  # happens is that days_warning and days_critical will not be written to
  # /etc/dd-agent/conf.d/http_check.yaml but the other values will with the code
  # as-is below. This has to do with quoting the boolean value for
  # "check_certificate_expiration" which prevents the days_warning and
  # days_critical blocks from being written as seen here in the erb:
  # https://github.com/DataDog/puppet-datadog-agent/blob/master/templates/agent-conf.d/http_check.yaml.erb#L45-L52
  # By simply removing the quotes these key values will be written to the
  # Datadog http_check configuration file.
  {
    sitename => "customer_test_1",
    url      => "https://www.google.com",
    no_proxy => "true",
    check_certificate_expiration => "true", # remove the quotes around true
    days_warning  => "30", # won't write to file until the above is fixed
    days_critical => "14", # won't write to file until the above is fixed
    tags     => "ssl_expiry",
  },
  {
    sitename => "customer_test_2",
    url      => "https://www.yahoo.com",
    no_proxy => "true",
    check_certificate_expiration => "true", # remove the quotes around true
    days_warning  => "30", # won't write to file until the above is fixed
    days_critical => "14", # won't write to file until the above is fixed
    tags     => "ssl_expiry",
  }]
}
