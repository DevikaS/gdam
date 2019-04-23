#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'hashdiff'

DB=ARGV[0].to_s
OLD_FILE_POSTFIX = '.old.json'
NEW_FILE_POSTFIX = '.new.json'
#var rr = []; db.schema.find({ agency: { $exists: false }},{group :1}).forEach( function(myDoc) { rr = rr.concat(myDoc.group); } ); print(JSON.stringify(rr));
SCHEMA_TO_EXPORT = [ 'schema','element','dictionary','group','notification_trigger','198','user','trigger_schema',
  'project','asset_filter','presentation','agency','acl','folder','system','agency_team','revisions',
  'activity','logo','asset_element_project_common','_meta','tv_order','tv_order_item','revision_guise_types','5','12',
  '25','30','469','1024','231','538','14004','24','13','asset_element_common','adkit','agency-logo',
  'specdb_metadata','tv_order_music','tv_order_item_music','schemas_map','billing','market','destination','usage_rights',
  'migrated','asset_markets','role','asset','199','206','6','228','352','19','77','195','27','177','4','354','14003','8',
  '17','7','18','213','197','16','3','20','35','57','193','251','43','175','174','14001','14002','9','11','29','176' ]


def export_shema_to_file (schema_group, postfix=NEW_FILE_POSTFIX)
  # schema with qroup, without field agency equal to global schema
  `mongoexport -d #{DB} -c schema -q '{group:"#{schema_group}", agency: { $exists: false }}' -o schema/#{schema_group}#{postfix}`
  if $?.to_i != 0
  	puts "failed to export schema #{schema_group} to file schema/#{schema_group}#{postfix}"
    exit(anInteger=$?.to_i)
  end
end

def escape(string)
    string.gsub(/\|/, "||").gsub(/'/, "|'").gsub(/\r/, "|r").gsub(/\n/, "|n").gsub(/\[/, "|[").gsub(/\]/, "|]")
end

SCHEMA_TO_EXPORT.each { |schema_group|
  #export_shema_to_file(schema_group, postfix=OLD_FILE_POSTFIX)
}
puts "##teamcity[testSuiteStarted name='global schema test']"

Dir.glob("schema/*#{OLD_FILE_POSTFIX}").each { |file_path|    
  schema_group = File.basename(file_path, OLD_FILE_POSTFIX)

  puts "##teamcity[testStarted name='#{schema_group}' captureStandardOutput='false']"
  puts "processing schema from group #{schema_group}"

  export_shema_to_file schema_group

  schema_old = File.read(file_path)  
  schema_new = File.read("schema/#{schema_group}#{NEW_FILE_POSTFIX}")

  diff = HashDiff.diff(JSON.parse(schema_old), JSON.parse(schema_new), :similarity => 1.0)
  puts "##teamcity[testFailed name='#{schema_group}' message='diff found' details='#{escape(JSON.pretty_generate(diff))}']" unless diff.to_s.empty? 
  puts "##teamcity[testFinished name='#{schema_group}']"
}
puts "##teamcity[testSuiteFinished name='global schema test']"