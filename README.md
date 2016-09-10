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

  - [Driver Overview](http://docs.hypertrack.io/v2.0/docs/drivers#get-driver-overview)

    `HyperTrack::Driver.retrieve(driver_id).overview`

  - [Map List for all Drivers](http://docs.hypertrack.io/v2.0/docs/drivers#get-map-list-for-all-drivers)

    `HyperTrack::Driver.map_list`

- [Customer](http://docs.hypertrack.io/v2.0/docs/customers)
  - [Create](http://docs.hypertrack.io/v2.0/docs/customers#create-a-customer)

    `HyperTrack::Customer.create(name: "SomeCustomer")`
    
  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/customers#retrieve-a-customer)

    `HyperTrack::Customer.retrieve(customer_id)`
  
  - [List](http://docs.hypertrack.io/v2.0/docs/customers#list-all-customers)

    `HyperTrack::Customer.list`

- [Destination](http://docs.hypertrack.io/v2.0/docs/destinations)
  - [Create](http://docs.hypertrack.io/v2.0/docs/destinations#create-a-destination)

    `HyperTrack::Destination.create(customer_id: "customer_id")`
    
  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/destinations#retrieve-a-destination)

    `HyperTrack::Destination.retrieve(destination_id)`
  
  - [List](http://docs.hypertrack.io/v2.0/docs/destinations#list-all-destinations)

    `HyperTrack::Destination.list`

- [Task](http://docs.hypertrack.io/v2.0/docs/tasks)
  - [Create](http://docs.hypertrack.io/v2.0/docs/tasks#create-a-task)

    `HyperTrack::Task.create`
    
  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/tasks#retrieve-a-task)

    `HyperTrack::Task.retrieve(task_id)`
  
  - [List](http://docs.hypertrack.io/v2.0/docs/tasks#list-all-tasks)

    `HyperTrack::Task.list`

  - [Editable URLs](http://docs.hypertrack.io/docs/tasks#create-editable-urls)

    `HyperTrack::Task.retrieve(task_id).editable_url(value)`

  - [Start](http://docs.hypertrack.io/docs/tasks#start-task)

    `task = HyperTrack::Task.retrieve(task_id)`
    
    `task.start({ start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] }, vehicle_type: "car", driver_id: driver_id, start_time: Time.now.strftime("%Y-%m-%dT%H:%M") })`

  - [Complete](http://docs.hypertrack.io/docs/tasks#complete-task)

    `task = HyperTrack::Task.retrieve(task_id)`
    
    `task.complete({ completion_location: { type: "Point", coordinates: [ 72.0, 19.3 ] }, completion_time: Time.now.strftime("%Y-%m-%dT%H:%M") })`

  - [Cancel](http://docs.hypertrack.io/docs/tasks#cancel-task)

    `HyperTrack::Task.retrieve(task_id).cancel`

  - [Update Destination Location](http://docs.hypertrack.io/docs/tasks#update-destination-location)

    `HyperTrack::Task.retrieve(task_id).update_destination({ location: { type: "Point", coordinates: [ 71.5, 19.0 ] } })`
