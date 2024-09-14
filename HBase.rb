#Your code goes here

import 'org.apache.hadoop.hbase.client.HTable'
import 'org.apache.hadoop.hbase.client.Put'

def jbytes( *args )
  args.map { |arg| arg.to_s.to_java_bytes }
end

def put_many( table_name, row, column_values)

  table = HTable.new( @hbase.configuration, table_name )
  p = Put.new( *jbytes( row ) )
  column_values.each do |whole_key,value|
    key_parts = whole_key.split(':')
    p.add( *jbytes( key_parts.first, key_parts.last, value ) )
  end

  table.put( p )
end

put_many  'wiki', 'I love this column database !', {
"text:" => "It Interesting how this works",
"revision:author" => "SKOLL23",
"revision:comment" => "My First Comment" }

get 'wiki', 'I love this column database !'











#Do not remove the exit call below
exit
