# RepoDeleter

Because deleting many repos from a cluttered Github profile is a major pain...

## Installation
- Install Elixir (1.6 or higher)
- Run `mix deps.get`

## Configuration
- Add your Github Personall Access Token as an environment variable:
  - To generate a token, visit: https://github.com/settings/tokens and click "Generate new token"
  - Copy the token string
  - Set GITHUB_PERSONAL_ACCESS_TOKEN to the token
- Also in your environment, set GITHUB_USERNAME to your Github username (e.g. bdfinlayson)

## Usage
The CLI accepts a number of switches:

- `--totalcount`: run this to view a count of the total number of repos in your Github account
- `--list [number]`: run this to list a certain number of repos from your account
- `--delete [repo_name]`: run this to delete a specific repo from your account
- `--deleteAll --confirm`: run this to cycle through all your repos and confirm whether you want to delete each one

## Example Usage
- Running `./repo_deleter --deleteAll --confirm` will give you the following output:

```
Do you want to delete this repo?: initialized-project
yes or no? y


Repository initialized-project successfully destroyed!
You now have this many respositories remaining:
+------------+-----+
| totalCount | 121 |
+------------+-----+

Do you want to delete this repo?: new-project
yes or no? y


Repository new-project successfully destroyed!
You now have this many respositories remaining:
+------------+-----+
| totalCount | 120 |
+------------+-----+
```

- Running `./repo_deleter --list 10` will give you the following output:

```
+----------------------------------+----------------------------+-----------+
| id                               | name                       | updatedAt |
| MDEwOlJlG9zaXRvcnkyOTM2NzYzOQ==  | savings-multiplied-metroui | 2015-1-19 |
| MDEwOlJcG9zaXRvcnkyOTk3OTMwNA==  | fivedayforecast            | 2015-1-30 |
| MDEwOllcG9zaXRvcnkzMDQ2NDkwOA==  | sampleapplicat.com         | 2015-5-1  |
| MDEwOJlcG9zaXRvcnkzMDU1ODczMw==  | square-painter-app         | 2015-2-25 |
| MDEwlJlcG9zaXRvcnkzMDU1OTQzNA==  | phone-book-app             | 2015-2-12 |
| MDEOlJlcG9zaXRvcnkzMDc2NDE0NA==  | petmate                    | 2015-2-20 |
| MDwOlJlcG9zaXRvcnkzMDg5NzM5OQ==  | flickr-api-app             | 2015-2-17 |
| MEwOlJlcG9zaXRvcnkzMDk0NzYxMg==  | random-circle-color-app    | 2015-2-18 |
| DEwOlJlcG9zaXRvcnkzMDk3MTE1NA==  | simple-quiz-app            | 2015-2-18 |
| DEwOlJlcG9zaXRvcnkzMTAzMDU5Mg==  | student-object-app         | 2015-2-19 |
+----------------------------------+----------------------------+-----------+
```

