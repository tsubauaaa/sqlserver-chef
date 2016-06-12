sqlserver Cookbook
===============
mackerel-agent for windows install

Requirements
------------
platforms:windows server 2012R2~

Attributes
----------
TODO: List your cookbook attributes here.

#### sqlserver::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['sqlserver']['iso_url']</tt></td>
    <td>String</td>
    <td>url for download microsoft sql server iso file</td>
    <td><tt>https://DOWNLOAD_YOUR_ISO_FILE_URL</tt></td>
  </tr>
  <tr>
    <td><tt>['sqlserver']['iso_file']</tt></td>
    <td>String</td>
    <td>microsoft sql server iso file name</td>
    <td><tt>SQLServer2014SP1-FullSlipstream-x64-JPN.iso</tt></td>
  </tr>
  <tr>
    <td><tt>['sqlserver']['volume_name']</tt></td>
    <td>String</td>
    <td>volume name that you mount iso file</td>
    <td><tt>SQL2014_x64_JPN</tt></td>
  </tr>
  <tr>
    <td><tt>['sqlserver']['instance_name']</tt></td>
    <td>String</td>
    <td>sql server instance name</td>
    <td><tt>MSSQLSERVER</tt></td>
  </tr>
  <tr>
    <td><tt>['sqlserver']['agent_account']</tt></td>
    <td>String</td>
    <td>sql server agent account</td>
    <td><tt>NT Service\SQLSERVERAGENT</tt></td>
  </tr>
  <tr>
    <td><tt>['sqlserver']['service_account']</tt></td>
    <td>String</td>
    <td>sql server service account</td>
    <td><tt>NT Service\MSSQLSERVER</tt></td>
  </tr>
  <tr>
    <td><tt>['sqlserver']['service_account_password']</tt></td>
    <td>String</td>
    <td>password of sql server service account</td>
    <td><tt>Kddi$077</tt></td>
  </tr>
  <tr>
    <td><tt>['sqlserver']['system_admin']</tt></td>
    <td>String</td>
    <td>Administrator account</td>
    <td><tt>Administrator</tt></td>
  </tr>
  <tr>
    <td><tt>['sqlserver']['system_admin_password']</tt></td>
    <td>String</td>
    <td>password of Administrator account</td>
    <td><tt>123Password</tt></td>
  </tr>
  <tr>
    <td><tt>['sqlserver']['install_directory']</tt></td>
    <td>String</td>
    <td>install directory of microsoft sql server</td>
    <td><tt>C:\Program Files\Microsoft SQL Server</tt></td>
  </tr>
  <tr>
    <td><tt>['sqlserver']['wow64_directory']</tt></td>
    <td>String</td>
    <td>windows on windows64 install directory of microsoft sql server</td>
    <td><tt>C:\Program Files (x86)\Microsoft SQL Server</tt></td>
  </tr>
</table>

Usage
-----
#### sqlserver::default
Just include `sqlserver::default` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sqlserver::default]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Distributed under the [MIT License][mit].
