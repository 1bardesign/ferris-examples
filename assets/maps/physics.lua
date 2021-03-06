return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 40,
  height = 23,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 6,
  nextobjectid = 14,
  backgroundcolor = { 190, 214, 253 },
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      filename = "tiles.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 40,
      height = 23,
      id = 2,
      name = "bg",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 398,
        0, 0, 0, 0, 0, 0, 942, 942, 939, 939, 940, 939, 939, 939, 941, 939, 939, 939, 939, 939, 939, 939, 939, 939, 941, 939, 939, 940, 939, 939, 942, 942, 0, 0, 0, 0, 0, 398, 398, 398,
        0, 0, 0, 0, 0, 0, 0, 937, 0, 0, 0, 0, 0, 0, 937, 0, 0, 0, 0, 0, 0, 0, 0, 0, 937, 0, 0, 0, 0, 0, 937, 0, 0, 0, 0, 0, 0, 398, 398, 398,
        343, 344, 345, 346, 0, 0, 0, 937, 0, 0, 0, 0, 0, 0, 937, 0, 0, 0, 0, 0, 0, 0, 0, 0, 937, 0, 0, 0, 0, 0, 937, 0, 0, 0, 0, 0, 0, 398, 398, 398,
        375, 376, 377, 378, 0, 0, 939, 941, 940, 940, 940, 940, 940, 940, 941, 939, 0, 0, 0, 288, 0, 0, 0, 0, 937, 0, 0, 0, 0, 0, 937, 0, 0, 0, 0, 397, 398, 398, 398, 398,
        407, 408, 409, 410, 0, 0, 0, 937, 0, 0, 0, 0, 0, 0, 937, 0, 0, 0, 315, 320, 0, 0, 0, 0, 937, 0, 0, 0, 0, 0, 937, 0, 0, 0, 0, 429, 430, 398, 398, 398,
        439, 440, 441, 442, 0, 0, 0, 937, 0, 0, 0, 0, 0, 0, 937, 315, 320, 0, 347, 352, 0, 337, 338, 398, 398, 398, 398, 398, 748, 749, 750, 751, 0, 0, 0, 0, 0, 0, 0, 398,
        471, 472, 473, 474, 0, 0, 0, 938, 0, 0, 0, 0, 0, 0, 938, 347, 381, 382, 383, 384, 0, 369, 370, 398, 398, 398, 398, 398, 366, 431, 0, 0, 0, 0, 0, 0, 0, 337, 338, 398,
        503, 504, 505, 506, 0, 0, 0, 938, 0, 0, 0, 0, 0, 369, 398, 368, 0, 0, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 399, 0, 0, 0, 0, 0, 0, 0, 0, 0, 398, 398,
        0, 0, 0, 0, 0, 0, 0, 938, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 431, 0, 0, 0, 0, 398, 398, 0, 0, 398, 398, 398,
        0, 0, 0, 0, 0, 0, 398, 398, 0, 0, 0, 0, 0, 397, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 397, 398, 398, 0, 0, 0, 0, 0, 398, 398, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 398, 398, 399, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 748, 749, 750, 751, 398, 400, 429, 430, 398, 0, 0, 333, 0, 0, 398, 398, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 398, 398, 398, 0, 0, 0, 337, 338, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 339, 340, 748, 749, 750, 751, 0, 333, 334, 398, 398, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 398, 0, 0, 0, 369, 370, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 371, 372, 398, 398, 340, 0, 0, 365, 366, 398, 398, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 372, 365, 398, 398, 398, 398, 398, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 398, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 40,
      height = 23,
      id = 1,
      name = "fg",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 141, 268, 72, 102, 143, 143, 143,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 173, 103, 104, 143, 143, 143, 143,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 159, 160, 130, 143, 143, 143, 144, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 191, 192, 141, 131, 132, 175, 176, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 121, 122, 123, 0, 0, 0, 0, 0, 173, 175, 176, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 105, 70, 71, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67, 68, 69, 102, 143, 144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 177, 20, 82, 81, 23, 24, 0, 0, 99, 100, 267, 193, 139, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 51, 81, 52, 114, 193, 55, 56, 0, 0, 137, 138, 193, 193, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 105, 66, 65,
        65, 66, 65, 67, 0, 0, 0, 0, 0, 0, 0, 67, 68, 22, 83, 84, 193, 193, 193, 328, 264, 0, 0, 169, 170, 161, 164, 175, 0, 0, 0, 0, 109, 71, 103, 66, 72, 133, 134, 97,
        97, 98, 97, 103, 75, 0, 0, 0, 0, 0, 0, 99, 103, 136, 193, 193, 193, 193, 193, 193, 296, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 141, 104, 97, 98, 329, 165, 166, 193,
        193, 193, 193, 129, 161, 65, 75, 76, 0, 0, 0, 137, 131, 132, 193, 193, 193, 193, 193, 207, 208, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 173, 267, 131, 132, 129, 193, 193, 193,
        193, 193, 193, 193, 193, 193, 131, 108, 0, 0, 0, 169, 170, 129, 161, 162, 229, 230, 231, 239, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 164, 193, 193, 193, 193, 193,
        193, 193, 193, 193, 193, 193, 193, 98, 79, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 328, 193, 193, 193, 193, 193, 193,
        193, 193, 193, 193, 193, 193, 193, 193, 111, 112, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 295, 231, 193, 193, 193, 193, 193,
        193, 193, 193, 193, 193, 193, 193, 193, 662, 97, 66, 65, 75, 76, 0, 0, 77, 78, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 262, 264, 322, 193, 193, 193, 193, 193, 193,
        193, 193, 193, 193, 193, 193, 193, 662, 662, 662, 98, 97, 97, 108, 0, 0, 109, 110, 328, 257, 290, 257, 259, 0, 0, 0, 0, 0, 0, 0, 0, 295, 193, 193, 193, 193, 193, 193, 193, 193,
        193, 193, 193, 193, 193, 193, 193, 662, 662, 662, 662, 131, 132, 103, 69, 71, 72, 131, 132, 193, 662, 328, 290, 385, 386, 389, 390, 391, 392, 679, 680, 322, 321, 193, 193, 193, 193, 193, 193, 193,
        193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 161, 162, 101, 102, 129, 130, 193, 193, 193, 193, 321, 417, 418, 421, 422, 423, 424, 629, 712, 427, 193, 725, 790, 727, 193, 193, 193, 193,
        193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 449, 450, 422, 422, 422, 456, 661, 789, 726, 726, 791, 193, 789, 726, 733, 193, 193,
        193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 485, 193, 486, 488, 633, 630, 630, 634, 193, 193, 193, 193, 763, 193, 193,
        193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 667, 54, 193, 193, 193, 193, 193, 193, 763, 193, 193,
        193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 193, 667, 54, 115, 116, 193, 193, 193, 193, 763, 193, 193
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "collision",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "polyline",
          x = -0.363636,
          y = 96.1818,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -49.6364, y = -122.848 },
            { x = -44.875, y = -38.75 },
            { x = 0.363636, y = -24.1818 },
            { x = 32.3636, y = -24.1818 },
            { x = 32.3636, y = -16.1818 },
            { x = 40.3636, y = -8.1818 },
            { x = 50.3864, y = -7.30682 },
            { x = 69.5114, y = 12.2045 },
            { x = 76.0341, y = 14.4773 },
            { x = 80.7443, y = 23.4773 },
            { x = 98.3295, y = 24.6023 },
            { x = 112.545, y = 39.6364 },
            { x = 128.545, y = 39.8182 },
            { x = 133.193, y = 31.0341 },
            { x = 139.125, y = 27.7159 },
            { x = 142.307, y = 23.3977 },
            { x = 147.455, y = 24.1818 },
            { x = 152.909, y = 31.8182 },
            { x = 179.818, y = 31.8182 },
            { x = 183.818, y = 33.6364 },
            { x = 190, y = 49.4545 },
            { x = 199.273, y = 55.8182 },
            { x = 197.552, y = 62.7443 },
            { x = 200.702, y = 63.8977 },
            { x = 227.04, y = 63.7386 },
            { x = 232.182, y = 55.4545 },
            { x = 232.727, y = 40.3636 },
            { x = 236.364, y = 42.5455 },
            { x = 246.545, y = 42.5455 },
            { x = 248.182, y = 40 },
            { x = 248.727, y = 26.5455 },
            { x = 256.182, y = 23.8352 },
            { x = 264.364, y = 23.8182 },
            { x = 264.347, y = 7.97161 },
            { x = 264.057, y = -0.34657 },
            { x = 260.36, y = -8.46021 },
            { x = 256.414, y = -11.0738 },
            { x = 256.364, y = -17.0454 },
            { x = 260.846, y = -24.3579 },
            { x = 280.17, y = -24.3011 },
            { x = 296.17, y = -24.3011 },
            { x = 301.977, y = -32.1761 },
            { x = 322, y = -32.1818 },
            { x = 367.864, y = -57.6818 }
          },
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "polygon",
          x = 87.9565,
          y = 72.0245,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0.1875, y = 18.375 },
            { x = 9.625, y = 23.7813 },
            { x = 16.1875, y = 31.9375 },
            { x = 68.75, y = 31.6875 },
            { x = 75.2813, y = 26.25 },
            { x = 80.0625, y = 19.3125 },
            { x = 79.875, y = -0.6875 },
            { x = 65.8125, y = -16 },
            { x = 48, y = -16.1875 },
            { x = 40, y = -8.1875 },
            { x = 31.0313, y = -8.1875 },
            { x = 23.875, y = -0.25 }
          },
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "polygon",
          x = 184.239,
          y = 39.8977,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = -0.239, y = 8.1023 },
            { x = -0.113636, y = 26.7159 },
            { x = 8.6705, y = 32.2102 },
            { x = 15.5455, y = 39.5455 },
            { x = 36.5455, y = 39.5455 },
            { x = 39.2727, y = 37.0909 },
            { x = 39.5455, y = 19.7273 },
            { x = 44.5455, y = 17.4545 },
            { x = 47.5455, y = 11.6364 },
            { x = 47.6343, y = -0.220202 },
            { x = 20.9421, y = -0.016351 },
            { x = 15.761, y = 8.1023 }
          },
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "polyline",
          x = 320,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 50.875, y = 30.75 },
            { x = 0, y = 0 },
            { x = -8, y = 0 },
            { x = -11.375, y = 9.875 },
            { x = -19.5, y = 15.875 },
            { x = -26.625, y = 16 },
            { x = -31.375, y = 21.75 },
            { x = -40.25, y = 23.75 },
            { x = -43.75, y = 18.75 },
            { x = -48, y = 10.75 },
            { x = -48, y = -2.75 },
            { x = -52.25, y = -5.625 },
            { x = -55.875, y = -16 },
            { x = -61.625, y = -60.875 }
          },
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "polyline",
          x = 224,
          y = 48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 32, y = 0 },
            { x = 32, y = 8 },
            { x = 0, y = 8 }
          },
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "polyline",
          x = 160,
          y = 88,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 24, y = 0 },
            { x = 24, y = 8 },
            { x = -8, y = 8 }
          },
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "polygon",
          x = 208,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 32, y = 0 },
            { x = 32, y = 8 },
            { x = 0, y = 8 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "water",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 184,
          y = 136,
          width = 48,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "objects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 4,
          name = "dispenser",
          type = "",
          shape = "point",
          x = 88.25,
          y = 12.75,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "player",
          type = "",
          shape = "point",
          x = 306.375,
          y = 55.875,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "dispenser path",
          type = "path",
          shape = "polyline",
          x = 59.25,
          y = 11.75,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0.75, y = 0.25 },
            { x = 184.833, y = 0.166667 }
          },
          properties = {}
        }
      }
    }
  }
}
