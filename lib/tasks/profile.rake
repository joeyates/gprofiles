namespace :profile do

  desc "Import a gprof file"
  task :import, [ :gprof_path_name ] => [ :environment ] do | t, args |
    raise "No gprof file supplied"                                if args.gprof_path_name.nil?
    raise "Gprof file '#{ args.gprof_path_name }' does not exist" if ! File.exist?( args.gprof_path_name )

    Profile.transaction do
      Profile.import( args.gprof_path_name )
    end
  end

end
