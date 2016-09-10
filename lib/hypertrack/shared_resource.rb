module HyperTrack
  class SharedResource
    extend HyperTrack::ApiOperations::Common::Create
    extend HyperTrack::ApiOperations::Common::Retrieve
    extend HyperTrack::ApiOperations::Common::List

    VALID_VEHICLE_TYPES = [:walking, :bicycle, :motorcycle, :car, :'3-wheeler', :van] #[:flight, :train, :ship]

    attr_accessor :id

    def initialize(id, opts)
      @id = id
      @values = Util.symbolize_keys(opts)
    end

    def [](k)
      @values[k.to_sym]
    end

    def update_value(k, v)
      @values[k.to_sym] = v
    end

    def keys
      @values.keys
    end

    def values
      @values.values
    end

    def to_json(*a)
      JSON.generate(@values)
    end

    protected

    def method_missing(name, *args)
      return @values[name.to_sym] if @values.has_key?(name.to_sym)

      super
    end

    private

    def self.get_class_name
      # To-Do: Umm.. Find some better approach
      Object.const_get(self.name)
    end

    def self.valid_vehicle_type?(vehicle)
      VALID_VEHICLE_TYPES.include?(vehicle.to_s.downcase.to_sym)
    end

  end
end
