# vetev Latest, kde je uchovavan posledni upraveny profil
# vetev Main, kde jsou general hotkeys
# snadna skalovatelnost pro coop commandery
# vetev pro kazdou rasu, verzovana


# pro kazdou slozku: najde nejcerstvejsi file, ten zpropaguje do vsech slozek jako Latest
# vyhodi prompt, na jakou vetev ji chci zapsat a jake verzovaci cislo
# pak provede

# budu potrebovat:
# prepinani mezi adresari
# zjistovat date_modified o souborech
# mazat soubory
# kopirovat soubory
require 'fileutils'
# User's account number (eg. 12345678)
$profile_in_use = ""

# All accounts' profile names
$hotkey_profile_names = Dir.glob("*/")

# Hotkey file that user wants to propagate
$hottest_hotkeys_path = ""



def last_modified_file(dir, profile_nums, options = {})
	default = Dir.pwd
	arr = Array.new
	most_recent_timestamp = ""
	profile_nums.each do |profile_num|
		path = File.join(Dir.pwd, profile_num, "Hotkeys")
		Dir.chdir(path)
		newest = Dir["#{dir}**/*#{options[:ext]}"].sort_by { |p| File.mtime(p) }.last
		if most_recent_timestamp == "" || most_recent_timestamp > File.mtime(newest)
			most_recent_timestamp = File.mtime(newest)
			most_recent_timestamp.inspect
		end
		arr << newest
		Dir.chdir(default)
	end
	return arr
end

# Returns the filename of newly created profile
def user_prompt(files)
	puts "These are your profiles' most recently updated hotkeys:"
	i = 1
	files.each do |f| 
		if f != nil
			puts "\t(#{i})..." + f.to_s
		else
			puts "\t(#{i})... Empty!"
		end
		i += 1
	end
 
	$hottest_hotkeys_path = files[get_propagate_input(i) - 1]
	new_filename = get_filename_input
end

def propagate_profile (new_filename)
	i = 0
	$hotkey_profile_names.each do |profile_num|
		path = (File.dirname(File.absolute_path(__FILE__))+"/" + $hotkey_profile_names[i] +"Hotkeys")
		Dir.chdir(path)

		new_on_branch = File.new(new_filename.to_s, "w+")
		latest = File.new("Latest.SC2Hotkeys", "w+")
		#p $hottest_hotkeys_path
		#p File.absolute_path(new_on_branch)
		FileUtils.copy_file($hottest_hotkeys_path, File.absolute_path(new_on_branch))
		puts "Copied " + new_filename + " to " + File.absolute_path(new_on_branch)
		FileUtils.copy_file($hottest_hotkeys_path, latest.path)
		puts "Updated Latest.SC2Hotkeys"
		path = path[0..-19]
		Dir.chdir(path)
		i += 1
	end
end

def get_propagate_input(prof_cnt)
	puts "\nWhich one do you wish to propagate?"
	resp = gets.strip
	resp = Integer(resp)
	if resp >= prof_cnt || resp < 1
		raise "Answer out of bounds"
	end
	$profile_in_use = $hotkey_profile_names[resp - 1]
	return resp
end

def get_filename_input
	puts "What branch would you like to update? (Z/T/P/M)"
	resp = gets.strip
	resp = resp.upcase
	puts "What version would you like to create? (eg. 2.0.4.12)"
	version = gets.strip
	
	case resp
	when 'Z'
		return "Zerg_v." + version+ ".SC2Hotkeys"
	when 'T' 
		return "Terran_v." + version + ".SC2Hotkeys"
	when 'P'
		return "Protoss_v." + version+ ".SC2Hotkeys"
	when 'M'
		return "Main_v." + version+ ".SC2Hotkeys"
	else
		raise "Wrong user input, use either Z, T, P or M as answers!"
	end
end


newest_profiles = last_modified_file('.', $hotkey_profile_names, :ext => '.SC2Hotkeys')
new_filename = user_prompt(newest_profiles)
propagate_profile(new_filename)
puts "Profiles synchronized! Press enter to quit."
gets
# Do you want to propagate to Main?