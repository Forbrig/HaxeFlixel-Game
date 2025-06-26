# HaxeFlixel Game

A 2D game built with [HaxeFlixel](https://haxeflixel.com/). Automatically deployed to GitHub Pages: [Play here!](https://forbrig.github.io/HaxeFlixel-Game/)

## Controls

- **W, A, S, D**: Move player
- **SPACE**: Throw shurikens

## Setup & Development

1. **Install dependencies:**
   ```sh
   haxelib install flixel
   haxelib install formatter
   haxelib install checkstyle
   ```
2. **Format code:**
   ```sh
   haxelib run formatter -s source
   ```
3. **Check code style:**
   ```sh
   haxelib run checkstyle source
   ```

- Formatting and linting rules are configured in `.haxefmt.json` and `checkstyle.json`.
- For best experience, use [VS Code](https://code.visualstudio.com/) with the [vshaxe extension](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe).

## Resources

- [HaxeFlixel Documentation](https://haxeflixel.com/documentation/)
- [Haxe Language](https://haxe.org/documentation/introduction/)

---

Enjoy playing and hacking on this project!
