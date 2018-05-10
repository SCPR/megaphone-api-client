[![Build Status](https://circleci.com/gh/SCPR/megaphone_client.png)](https://circleci.com/gh/SCPR/megaphone_client)

# Megaphone Client
An unofficial Ruby client for the Megaphone API

## Installation
```bash
gem 'megaphone_client', github:"scpr/megaphone_client"
```

## Usage
**Note:** Megaphone API props, such as `externalId`, are in camelCase instead of snake_case because Megaphone's API expects it when accessing their API. So when passing params or putting/posting a hash, use camelCase. When interfacing with the gem's API, use snake_case.

### Configuration
Configure your app to connect to Megaphone, either in an initializer or from your environment files:

```ruby
megaphone = MegaphoneClient.new({
  token: "{megaphone api token}",
  network_id: "{megaphone network id}",
  organization_id: "{megaphone organization id}"
})
```

### Podcasts

#### Creating a podcast

```ruby
megaphone.podcasts.new({
  title: "{episode title}",
  pubdate: "2020-06-01T14:54:02.690Z"
})
```

#### Retrieving a list of podcasts

```ruby
megaphone.podcasts
```

#### Retrieving a podcast

```ruby
megaphone.podcast("{podcast id}")
```

#### Updating a podcast

**Note:** the properties in `update` are written in camelCase because it's expected by the Megaphone API

```ruby
megaphone.podcast("{podcast id}").update({
  title: "New Title"
})
```

#### Deleting a podcast

```ruby
megaphone.podcast("{podcast id}").delete
```

### Episodes

#### Searching

**Note:** the property `externalId` is written in camelCase because it's expected by the Megaphone API

```ruby
megaphone.episodes.search({ externalId: obj_key })
```

#### Creating an episode

```ruby
megaphone.podcast("{podcast_id}").episodes.new({
  title: "{episode title}",
  pubdate: "2020-06-01T14:54:02.690Z"
})
```


#### Retrieving an episode

```ruby
megaphone.podcast("{podcast id}").episode("{episode id}")
```

#### Updating an episode

**Note:** the properties in `update` are written in camelCase because it's expected by the Megaphone API

```ruby
megaphone.podcast("{podcast id}").episode("{episode id}").update({
  preCount: 1,
  postCount: 2,
  insertionPoints: ["10.1", "15.23", "18"]
})
```

#### Deleting an episode

```ruby
megaphone.podcast("{podcast id}").episode("{episode id}").delete
```

## Tests

#### To run the tests:
```bash
bundle exec rspec spec
```

## Documentation

You can view MegaphoneClient's documentation in RDoc format here:
http://www.rubydoc.info/github/SCPR/megaphone_client/master/

## Contributing

Pull Requests are encouraged! Suggested practice:
- Fork and make changes
- Submit a PR from fork to this master