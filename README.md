# HyperTrack RubyGem

### Initialization:
```ruby
require 'hypertrack'
HyperTrack.secret_key = "<YOUR_SECRET_KEY>"
```

## HyperTrack - Resources

- [Driver](http://docs.hypertrack.io/v2.0/docs/drivers)
  - [Create](http://docs.hypertrack.io/v2.0/docs/drivers#create-a-driver)
    ```ruby
    HyperTrack::Driver.create(name: "SomeDriver", vehicle_type: "car")
    ```
    
  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/drivers#retrieve-a-driver)
    ```ruby
    HyperTrack::Driver.retrieve(driver_id)
    ```
  
  - [List all](http://docs.hypertrack.io/v2.0/docs/drivers#list-all-drivers)
    ```ruby
    HyperTrack::Driver.list
    ```

  - [Driver Overview](http://docs.hypertrack.io/v2.0/docs/drivers#get-driver-overview)
    ```ruby
    HyperTrack::Driver.retrieve(driver_id).overview
    ```

  - [Map List for all Drivers](http://docs.hypertrack.io/v2.0/docs/drivers#get-map-list-for-all-drivers)
    ```ruby
    HyperTrack::Driver.map_list
    ```

- [Customer](http://docs.hypertrack.io/v2.0/docs/customers)
  - [Create](http://docs.hypertrack.io/v2.0/docs/customers#create-a-customer)
    ```ruby
    HyperTrack::Customer.create(name: "SomeCustomer")
    ```

  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/customers#retrieve-a-customer)
    ```ruby
    HyperTrack::Customer.retrieve(customer_id)
    ```
  - [List](http://docs.hypertrack.io/v2.0/docs/customers#list-all-customers)

    ```ruby
    HyperTrack::Customer.list
    ```

- [Destination](http://docs.hypertrack.io/v2.0/docs/destinations)
  - [Create](http://docs.hypertrack.io/v2.0/docs/destinations#create-a-destination)

    ```ruby
    HyperTrack::Destination.create(customer_id: "customer_id")
    ```
    
  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/destinations#retrieve-a-destination)

    ```ruby
    HyperTrack::Destination.retrieve(destination_id)
    ```
  
  - [List](http://docs.hypertrack.io/v2.0/docs/destinations#list-all-destinations)

    ```ruby
    HyperTrack::Destination.list
    ```

- [Task](http://docs.hypertrack.io/v2.0/docs/tasks)
  - [Create](http://docs.hypertrack.io/v2.0/docs/tasks#create-a-task)

    ```ruby
    HyperTrack::Task.create
    ```
    
  - [Retrieve](http://docs.hypertrack.io/v2.0/docs/tasks#retrieve-a-task)

    ```ruby
    HyperTrack::Task.retrieve(task_id)
    ```
  
  - [List](http://docs.hypertrack.io/v2.0/docs/tasks#list-all-tasks)

    ```ruby
    HyperTrack::Task.list
    ```

  - [Editable URLs](http://docs.hypertrack.io/docs/tasks#create-editable-urls)

    ```ruby
    HyperTrack::Task.retrieve(task_id).editable_url({ editable: value })
    ```

  - [Start](http://docs.hypertrack.io/docs/tasks#start-task)

    ```ruby
    task = HyperTrack::Task.retrieve(task_id)
    task.start({ start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] }, vehicle_type: "car", driver_id: driver_id, start_time: Time.now.strftime("%Y-%m-%dT%H:%M") })
    ```

  - [Complete](http://docs.hypertrack.io/docs/tasks#complete-task)

    ```ruby
    task = HyperTrack::Task.retrieve(task_id)
    task.complete({ completion_location: { type: "Point", coordinates: [ 72.0, 19.3 ] }, completion_time: Time.now.strftime("%Y-%m-%dT%H:%M") })
    ```

  - [Cancel](http://docs.hypertrack.io/docs/tasks#cancel-task)

    ```ruby
    HyperTrack::Task.retrieve(task_id).cancel
    ```

  - [Update Destination Location](http://docs.hypertrack.io/docs/tasks#update-destination-location)

    ```ruby
    HyperTrack::Task.retrieve(task_id).update_destination({ location: { type: "Point", coordinates: [ 71.5, 19.0 ] } })
    ```

- [Trip](http://docs.hypertrack.io/docs/trips)
  - [Start](http://docs.hypertrack.io/docs/trips#start-a-trip)

    ```ruby
    HyperTrack::Trip.create({ driver_id: driver_id, start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] }, tasks: [task1_id, task2_id], vehicle_type: "car" })
    ```

  - [Retrieve](http://docs.hypertrack.io/docs/trips#retrieve-a-trip)

    ```ruby
    HyperTrack::Trip.retrieve(trip_id)
    ```

  - [List](http://docs.hypertrack.io/docs/trips#list-all-trips)

    ```ruby
    HyperTrack::Trip.list
    ```

  - [End Trip](http://docs.hypertrack.io/docs/trips#end-trip)

    ```ruby
    HyperTrack::Trip.retrieve(trip_id).end_trip({ end_location: { type: "Point", coordinates: [ 71.5, 19.0 ] } })
    ```

  - [Send ETAs](http://docs.hypertrack.io/docs/trips#sending-etas)

    ```ruby
    # Implement me
    ```

  - [Add Task](http://docs.hypertrack.io/docs/trips#adding-a-task-to-a-trip)

    ```ruby
    HyperTrack::Trip.retrieve(trip_id).add_task({ task_id: task_id })
    ```

  - [Remove Task](http://docs.hypertrack.io/docs/trips#removing-a-task-from-a-trip)

    ```ruby
    HyperTrack::Trip.retrieve(trip_id).remove_task({ task_id: task_id })
    ```

  - [Change task order](http://docs.hypertrack.io/docs/trips#changing-the-task-order)

    ```ruby
    HyperTrack::Trip.retrieve(trip_id).change_task_order({ task_order: [task1_id, task2_id] })
    ```

- [Neighbourhood](http://docs.hypertrack.io/docs/neighbourhoods)
  - [Retrieve](http://docs.hypertrack.io/docs/neighbourhoods#retrieve-a-neighborhood)
    ```ruby
    HyperTrack::Neighbourhood.retrieve(neighbourhood_id)
    ```

  - [List all](http://docs.hypertrack.io/docs/neighbourhoods#list-neighborhoods)
    ```ruby
    HyperTrack::Neighbourhood.list
    ```

- [Fleet](http://docs.hypertrack.io/docs/fleets)
  - [Create](http://docs.hypertrack.io/docs/fleets#create-a-fleet)

    ```ruby
    HyperTrack::Fleet.create(name: "some_fleet")
    ```

  - [Retrieve](http://docs.hypertrack.io/docs/fleets#retrieve-a-fleet)
    ```ruby
    HyperTrack::Fleet.retrieve(fleet_id)
    ```

  - [List all](http://docs.hypertrack.io/docs/fleets#list-all-fleets)
    ```ruby
    HyperTrack::Fleet.list
    ```

- [Hub](http://docs.hypertrack.io/docs/hubs)
  - [Create](http://docs.hypertrack.io/docs/hubs#create-a-hub)

    ```ruby
    HyperTrack::Hub.create(name: "some_hub")
    ```

  - [Retrieve](http://docs.hypertrack.io/docs/hubs#retrieve-a-hub)
    ```ruby
    HyperTrack::Hub.retrieve(hub_id)
    ```

  - [List all](http://docs.hypertrack.io/docs/hubs#list-all-hubs)
    ```ruby
    HyperTrack::Hub.list
    ```

- [Shift](http://docs.hypertrack.io/docs/shifts)
  - [Start](http://docs.hypertrack.io/docs/shifts#start-a-shift)

    ```ruby
    HyperTrack::Shift.create({ driver_id: "some_driver_id", start_location: { type: "Point", coordinates: [ 72.0, 19.0 ] } })
    ```

  - [Retrieve](http://docs.hypertrack.io/docs/shifts#retrieve-a-shift)
    ```ruby
    HyperTrack::Shift.retrieve(shift_id)
    ```

  - [List all](http://docs.hypertrack.io/docs/shifts#list-all-shifts)
    ```ruby
    HyperTrack::Shift.list
    ```

  - [End Shift](http://docs.hypertrack.io/docs/shifts#end-shift)
    ```ruby
    HyperTrack::Shift.retrieve(shift_id).end_shift(end_location: { type: "Point", coordinates: [ 72.0, 19.2 ] } })
    ```

- [Event](http://docs.hypertrack.io/docs/events)
  - [Retrieve](http://docs.hypertrack.io/docs/events#retrieve-an-event)
    ```ruby
    HyperTrack::Event.retrieve(event_id)
    ```

  - [List all](http://docs.hypertrack.io/docs/events#list-all-events)
    ```ruby
    HyperTrack::Event.list
    ```
