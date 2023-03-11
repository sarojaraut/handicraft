##How to Use package.json, the Core of Any Node.js Project or npm Package

The package.json file is the center of any Node.js project or npm package. It stores information about your project. There are only two required fields; "name" and "version", but it’s good practice to provide additional information about your project that could be useful to future users or maintainers.

A version is one of the required fields of your package.json file. This field describes the current version of your project. Here's an example:

"version": "1.2.0",

## Manage npm Dependencies By Understanding Semantic Versioning

Versions of the npm packages in the dependencies section of your package.json file follow what’s called Semantic Versioning (SemVer),  an industry standard for software versioning aiming to make it easier to manage dependencies.

This is how Semantic Versioning works according to the official website:

"package": "MAJOR.MINOR.PATCH"
The MAJOR version should increment when you make incompatible API changes.
The MINOR version should increment when you add functionality in a backwards-compatible manner.
The PATCH version should increment when you make backwards-compatible bug fixes. This means that PATCHes are bug fixes and MINORs add new features but neither of them break what worked before. Finally, MAJORs add changes that won’t work with earlier versions.

Expand Your Project with External Packages from npm
One of the biggest reasons to use a package manager, is their powerful dependency management. Instead of manually having to make sure that you get all dependencies whenever you set up a project on a new computer, npm automatically installs everything for you. But how can npm know exactly what your project needs? Meet the dependencies section of your package.json file

"dependencies": {
  "package-name": "version",
  "express": "4.14.0"
}


## Use the Tilde-Character to Always Use the Latest Patch Version of a Dependency
A useful way to freeze your dependencies if you need to make sure that different parts of your project stay compatible with each other. But in most use cases, you don’t want to miss bug fixes since they often include important security patches and (hopefully) don’t break things in doing so.

To allow an npm dependency to update to the latest PATCH version, you can prefix the dependency’s version with the tilde (~) character. Here's an example of how to allow updates to any 1.3.x version.

"package": "~1.3.8"

## Use the Caret-Character to Use the Latest Minor Version of a Dependency

Similar to how the tilde we learned about in the last challenge allows npm to install the latest PATCH for a dependency, the caret (^) allows npm to install future updates as well. The difference is that the caret will allow both MINOR updates and PATCHes.

"package": "^1.3.8"
This would allow updates to any 1.x.x version of the package.


