## N Tier Architecture

A multi-tier application is any application developed and distributed among more than one layer. It logically separates the different application-specific, operational layers. The number of layers varies by business and application requirements, but three-tier is the most commonly used architecture. Any application that depends on or uses a middleware application is known as a multi-tier application. A multi-tier application is also known as a multitiered application or n-tier application.
source: [techopedia.com](https://www.techopedia.com/definition/23599/multi-tier-application)

## Usage

  [examples](https://github.com/nsantiago2719/terraform-aws-n-tier/tree/master/examples) : Contains various examples on how to use the template.

  [modules](https://github.com/nsantiago2719/terraform-aws-n-tier/tree/master/modules) : Contains terraform modules that is customizable(my goal as much as possible) to create the resources needed for an n-tier architecture.

  [test](https://github.com/nsantiago2719/terraform-aws-n-tier/tree/master/test) : Test scripts written on go using [terratest](https://github.com/gruntwork-io/terratest) by [Gruntwork.io](https://gruntwork.io).

  In the folder modules said above contains different modules for you to be able to create an N-Tier architecture easily. An example of a full blown usage of this modules can be seen at 
  [create-all](https://github.com/nsantiago2719/terraform-aws-n-tier/tree/master/examples/create-all) example.

## Contribution

  * Fork the repo
  * Make changes on your fork repo
  * Feel free to submit any changes appropriate

## License

Copyright 2019 Norman Santiago

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
