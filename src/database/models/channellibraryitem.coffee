module.exports = (bookshelf, tablePrefix = '') ->
  ChannelLibraryItem = bookshelf.Model.extend({
    modelName: 'ChannelLibraryItem'
    tableName: tablePrefix + 'channel_library_items'
    hasTimestamps: true

    channel: ->
      return @belongsTo(bookshelf.model('Channel', 'channel_id'))
  }, {
    createTable_sqlite3: (t) ->
      t.increments('id').primary()
      t.integer('channel_id')
          .unsigned()
          .references(tablePrefix + 'channels.id')
          .onDelete('cascade')
      t.string('media_id', 255)
          .notNullable()
      t.specificType('title', 'text collate nocase')
          .notNullable()
      t.integer('length')
          .notNullable()
      t.string('media_type', 2)
      t.text('meta')
      t.unique(['channel_id', 'media_id', 'media_type'])
      t.index(['channel_id', 'title'])

    createTable_mysql: (t) ->
      t.increments('id').primary()
      t.integer('channel_id')
          .unsigned()
          .references(tablePrefix + 'channels.id')
          .onDelete('cascade')
      t.string('media_id', 255)
          .notNullable()
      t.specificType('title', 'text character set utf8mb4')
          .notNullable()
      t.integer('length')
          .notNullable()
      t.string('media_type', 2)
      t.text('meta')
      t.unique(['channel_id', 'media_id', 'media_type'])
      t.index(['channel_id', 'title'])

    createTable_pg: (t) ->
      t.increments('id').primary()
      t.integer('channel_id')
          .unsigned()
          .references(tablePrefix + 'channels.id')
          .onDelete('cascade')
      t.string('media_id', 255)
          .notNullable()
      t.specificType('title', 'citext')
          .notNullable()
      t.integer('length')
          .notNullable()
      t.string('media_type', 2)
      t.text('meta')
      t.unique(['channel_id', 'media_id', 'media_type'])
      t.index(['channel_id', 'title'])
  })

  bookshelf.model('ChannelLibraryItem', ChannelLibraryItem)

  return {
    model: ChannelLibraryItem
  }
