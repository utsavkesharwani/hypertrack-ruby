# HyperTrack RubyGem

### Initialization:
`HyperTrack.secret_key = "<YOUR_SECRET_KEY>"`

## HyperTrack - Resources

- [Driver](http://docs.hypertrack.io/v2.0/docs/drivers)
  - [Create](http://docs.hypertrack.io/v2.0/docs/drivers#create-a-driver)

    `HyperTrack::Driver.create(name: "SomeDriver", vehicle_type: "car")`
    
  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/drivers#retrieve-a-driver)

    `HyperTrack::Driver.retrieve(driver_id)`
  
  - [List all](http://docs.hypertrack.io/v2.0/docs/drivers#list-all-drivers)

    `HyperTrack::Driver.list`

- [Customer](http://docs.hypertrack.io/v2.0/docs/customers)
  - [Create](http://docs.hypertrack.io/v2.0/docs/customers#create-a-customer)

    `HyperTrack::Customer.create(name: "SomeCustomer")`
    
  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/customers#retrieve-a-customer)

    `HyperTrack::Customer.retrieve(driver_id)`
  
  - [List](http://docs.hypertrack.io/v2.0/docs/customers#list-all-customers)

    `HyperTrack::Customer.list`

- [Destination](http://docs.hypertrack.io/v2.0/docs/destinations)
  - [Create](http://docs.hypertrack.io/v2.0/docs/destinations#create-a-destination)

    `HyperTrack::Destination.create(name: "SomeOne", vehicle_type: "car")`
    
  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/destinations#retrieve-a-destination)

    `HyperTrack::Destination.retrieve(driver_id)`
  
  - [List](http://docs.hypertrack.io/v2.0/docs/destinations#list-all-destinations)

    `HyperTrack::Destination.list`

- [Task](http://docs.hypertrack.io/v2.0/docs/tasks)
  - [Create](http://docs.hypertrack.io/v2.0/docs/tasks#create-a-task)

    `HyperTrack::Task.create(name: "SomeOne", vehicle_type: "car")`
    
  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/tasks#retrieve-a-task)

    `HyperTrack::Task.retrieve(driver_id)`
  
  - [List](http://docs.hypertrack.io/v2.0/docs/tasks#list-all-tasks)

    `HyperTrack::Task.list`
