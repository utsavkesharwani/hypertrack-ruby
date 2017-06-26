module HyperTrack
  class SharedResource
    extend HyperTrack::ApiOperations::Common::Create
    extend HyperTrack::ApiOperations::Common::Retrieve
    extend HyperTrack::ApiOperations::Common::List
    include HyperTrack::ApiOperations::Common::Get
    include HyperTrack::ApiOperations::Common::Update

    VALID_VEHICLE_TYPES = [:walking, :bicycle, :motorcycle, :car, :'3-wheeler', :van] #[:flight, :train, :ship]

    attr_accessor :id

    def initialize(id, opts)
      @id = id
      @values = Util.symbolize_keys(opts)
    end

    def [](k)
      @values[k.to_sym]
    end

    def []=(k, v)
      @values[k.to_sym] = v
    end

    def keys
      @values.keys
    end

    def values
      @values.values
    end

    def to_json
      JSON.generate(@values)
    end

    protected

    def method_missing(name, *args)
      if name[-1] == "="
        name = name[0..-2]

        if @values.has_key?(name.to_sym)
          self[name.to_sym] = args[0]
          return
        end

      elsif @values.has_key?(name.to_sym)
        return @values[name.to_sym]
      end

      super
    end

    private

    def self.get_class_name
      # To-Do: Umm.. Find some better approach
      Object.const_get(self.name)
    end

  end
end
