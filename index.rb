# This script renders a Helm index.yaml file into nice HTML, similar to what `helm serve` does.

require 'yaml'

index = YAML::load_file(if ARGV.first.nil? then exit 1 else ARGV.first end)

puts %Q{
<html>
<head>
    <title>qoqodev charts</title>
    <link rel="icon" href="favicon.ico"/>
    <style type="text/css">
        body {
            font-family: Consolas, monaco, monospace;
            margin: 40px auto;
            max-width: 400px;
            line-height: 1.6;
        }
        ul {
            margin-bottom: 15px;
        }
    </style>
</head>
<h1>qoqodev charts</h1>
<body>
  <ul>
  #{
    index['entries'].map do |k,v|
      %Q{
        <li>#{k}
          <ul>
          #{
            v.map do |chart|
              %Q{
                <li>
                  <a href="#{chart['urls'].first}">#{chart['name']}-#{chart['version']}</a>
                </li>
              }
            end.join
          }
          </ul>
        </li>
      }
    end.join
  }
  </ul>
  <p>Last Generated: #{index['generated']}</p>
</body>
</html>
}
