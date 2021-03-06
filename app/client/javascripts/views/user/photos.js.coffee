Nali.View.extend UserPhotos:

  insertTo: -> '.UserInterface'

  events: [
    'hide on click at    .wrapper'
    'notHide on click at .photos'
  ]

  helpers:
    selectedCount: ->
      if count = @getOf @my.selectedPhotos, 'length'
        'Отмечено ' + count + ' фото'
      else 'Нажмите на фото, чтобы отметить его'

  onShow: ->
    @_( 'a.photos' ).addClass 'button_active'
    @photosBox ?= @element.find '.previews'
    @photosBox.niceScroll cursorborder: '1px #333 solid'

  onHide: ->
    @_( 'a.photos' ).removeClass 'button_active'
    @cancelIsClose = false
    @selectModeOff()
    @avatarModeOff()
    @photosBox.getNiceScroll().remove()

  notHide: ( event ) ->
    event.stopPropagation()

  selectModeOn: ->
    if @my.photos.length
      @element.find( '.photos' ).addClass 'selectionMode'
      @my.photos.selectModeOn()
    else @Notice.info 'Для начала загрузите фотографии'
    @

  selectModeOff: ->
    @element.find( '.photos' ).removeClass 'selectionMode'
    @my.photos.selectModeOff()
    @

  avatarModeOn: ->
    if @my.photos.length
      @element.find( '.photos' ).addClass 'avatarMode'
      @my.photos.avatarModeOn()
    else @Notice.info 'Для начала загрузите фотографии'
    @

  avatarModeOff: ->
    if @cancelIsClose then @hide()
    else
      @element.find( '.photos' ).removeClass 'avatarMode'
      @my.photos.avatarModeOff()
    @
