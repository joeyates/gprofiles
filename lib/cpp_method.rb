class CppMethod
  attr_reader :namespace
  attr_reader :class_name
  attr_reader :template_parameters
  attr_reader :method
  attr_reader :parameters

  def initialize( method )
    @raw = method
    parse
  end

  private

  def parse
    @namespace           = ''
    @class_name          = ''
    @parameters          = []
    @template_parameters = []

    rest = @raw.clone

    # drop const
    const = rest.match( /\s+const$/ )
    if const
      rest = const.pre_match
    end

    # allow '(&)' within the parameter list
    params = rest.match( /\(((\(&\)|[^\)])*)\)$/ )
    raise "Params not found in '#{ @raw }'" if params.nil?
    unless params[ 1 ].empty?
      @parameters = params[ 1 ]
    end

    rest = params.pre_match

    meth    = rest.match( /(?:\:\:)?([^\:]+)$/ )
    raise "No method name found" if meth.nil?
    @method = meth[ 1 ]

    rest = meth.pre_match

    temp_params = rest.match( /^([^<]+)<(.*)>$/ )
    if temp_params
      @template_parameters << temp_params[ 2 ].strip
      rest = temp_params[ 1 ]
    end

    klass    = rest.match( /([^\:]+)$/ )
    if klass
      @class_name = klass[ 1 ]
      rest = klass.pre_match
    end

    unless rest.empty?
      @namespace = rest.gsub( /\:\:/, '' )
    end
  end

end
