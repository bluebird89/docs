# [hyperapp](https://github.com/hyperapp/hyperapp)

1 KB JavaScript library for building web applications. <https://hyperapp.js.org>

## 使用

```
npm i hyperapp

import { h, app } from "hyperapp"

<script src="https://unpkg.com/hyperapp"></script>

const { h, app } = hyperapp
```

## 概念

* Virtual Nodes:A virtual node is a JavaScript object that represents an element in the DOM tree.
* Keys help identify which nodes were added, changed or removed from a list when a view is rendered. A key must be unique among sibling-nodes.

```
const node = h("div", { id: "app" }, [h("h1", {}, "Hi.")])
{
  name: "div",
  props: {
    id: "app"
  },
  children: [{
    name: "h1",
    props: {},
    children: ["Hi."]
  }]
}

const ImageGallery = ({ images }) =>
  images.map(({ hash, url, description }) => (
    <li key={hash}>
      <img src={url} alt={description} />
    </li>
  ))
```
