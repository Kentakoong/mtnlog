poetry version patch
poetry build
poetry publish

#get version from pyproject.toml

version=$(poetry version -s)

git add .
git commit -m "v$version"

git push