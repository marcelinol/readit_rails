[![Code Climate](https://codeclimate.com/github/marcelinol/readit_rails/badges/gpa.svg)](https://codeclimate.com/github/marcelinol/readit_rails) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/7217de81c5654e37b6e748cde909915c)](https://www.codacy.com/app/marcelinolucianom/readit_rails?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=marcelinol/readit_rails&amp;utm_campaign=Badge_Grade)  [![Test Coverage](https://codeclimate.com/github/marcelinol/readit_rails/badges/coverage.svg)](https://codeclimate.com/github/marcelinol/readit_rails/coverage) [![Issue Count](https://codeclimate.com/github/marcelinol/readit_rails/badges/issue_count.svg)](https://codeclimate.com/github/marcelinol/readit_rails) [![Build Status](https://travis-ci.org/marcelinol/readit_rails.svg?branch=master)](https://travis-ci.org/marcelinol/readit_rails)

This app has the API to receive the links and details, and also has the view to show it.

In the future, it could integrate with pocket, raindrop or send emails, whatever.

Hubot is already integrated with it, you can ask me for the script to recommend articles.
For those who know capybot, you can use `capybot recommend ARTICLE_ADDRESS as ARTICLE_TITLE` or only `capybot recommend ARTICLE_ADDRESS` and the app will get the title from the article's meta-tags.

The app is deployed and we use it at [Resultados Digitais](https://resultadosdigitais.com.br) [in here](http://readit-rails.herokuapp.com/).

## Contribute

- Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
- Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
- Fork the project.
- Start a feature/bugfix branch.
- Commit and push until you are happy with your contribution.
- Make sure to add tests for it.
- Open a Pull Request

If you are new to Open Source world, take a look at the [Contributor Convent](http://contributor-covenant.org/).

### Setup

- Clone the repo

```bash
bundle install
```

- Setup a .env to set an auth_token. It can be like this:

```
AUTH_TOKEN=xunda
```

- To create an article in local environment, you can use a curl like this:

```bash
curl -H "Authorization: Token token=xunda"  -d 'article[address]=http://pudim.com.br&article[title]=pudim-testing' http://localhost:3000/api/articles/create
```

## License

Read It is released under the [MIT License](https://opensource.org/licenses/MIT).
