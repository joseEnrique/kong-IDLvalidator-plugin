# Kong idlvalidator

A Kong plugin that enables an extra HTTP POST request before proxying the original.

## Description

In some cases, you may need to validate a request to a separate server or service using custom logic before Kong proxies it to your API.
Idlvalidator enables you to do that by allowing you to make an extra HTTP request before calling an API endpoint.

## Installation

### Development

Navigate to kong/plugins folder and clone this repo

<pre>
$ cd /path/to/kong/plugins
$ git clone https://github.com/pantsel/kong-idlvalidator-plugin idlvalidator
$ cd idlvalidator
$ luarocks make *.rockspec
</pre>

To make Kong aware that it has to look for the idlvalidator plugin, you'll have to add it to the custom_plugins property in your configuration file.

<pre>
custom_plugins:
    - idlvalidator
</pre>

Restart Kong and you're ready to go.

## luarocks

<pre>
$ luarocks install idlvalidator
</pre>


## Configuration

You can add the plugin on top of an API by executing the following request on your Kong server:

<pre>
$ curl -X POST http://kong:8001/apis/{api}/plugins \
    --data "name=idlvalidator" \
    --data "config.url=http://myserver.io/validate"
    --data "config.response=table"
    --data "config.timeout=10000"
    --data "config.keepalive=60000"
</pre>

<table><thead>
<tr>
<th>form parameter</th>
<th>default</th>
<th>description</th>
</tr>
</thead><tbody>
<tr>
<td><code>name</code></td>
<td></td>
<td>The name of the plugin to use, in this case: <code>idlvalidator</code></td>
</tr>
<tr>
<td><code>config.url</code><br><em>required</em></td>
<td></td>
<td>The URL to which the plugin will make a JSON <code>POST</code> request before proxying the original request.</td>
</tr>
<tr>
<td><code>config.response</code><br><em>required</em></td>
<td></td>
<td>The type of response the idlvalidator service is going to respond with</td>
</tr>
<tr>
<td><code>config.timeout</code></td>
<td></td>
<td>Timeout (miliseconds) for the request to the URL specified above. Default value is 10000.</td>
</tr>
<tr>
<td><code>config.keepalive</code></td>
<td></td>
<td>Keepalive time (miliseconds) for the request to the URL specified above. Default value is 60000.</td>
</tr>
</tbody></table>

Idlvalidator will execute a JSON <code>POST</code> request to the specified <code>url</code> with the following body:

<table>
    <tr>
        <th>Attribute</th>
        <th>Description</th>
    </tr>
    <tr>
    <td><code>body_data</code></td>
    <td><small>The body of the original request</small></td>
    </tr>
    <tr>
        <td><code>url_args</code></td>
        <td><small>The url arguments of the original request</small></td>
    </tr>
    <tr>
        <td><code>headers</code></td>
        <td><small>The headers of the original request</small></td>
    </tr>
</table>

In the scope of your own endpoint, you may validate any of these attributes and accept or reject the request according to your needs. If an HTTP response code of 299 or less is returned, the request is accepted. Any response code above 299 will cause the request to be rejected.  

