@Rooms  = new Mongo.Collection "rooms"
@Messages  = new Mongo.Collection "messages"

if Meteor.isClient
 Session.setDefault "activeRoom", "Ruby"
 Template.main.helpers
   rooms: ->
    Rooms.find()

  Template.main.events
    "click .room-name":(e) ->
      Session.set "activeRoom", @name

  Template.room.helpers
    activeRoom: ->
      Session.get "activeRoom"

    messages: ->
      Messages.find({room: Session.get "activeRoom"})

  Template.room.events
    "keypress #message":(e,t) ->
      message = t.$('#message').val().trim()
      username = if Meteor.user() then Meteor.user().profile.name else "Anonymous dude"
      if e.which is 13 and message isnt ""
        Messages.insert
          message: message
          username: username
          room: Session.get "activeRoom"
          time: Date.now()
        t.$('#message').val('')



  
