// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

ListModel {
    ListElement{
        lid: 1
        background:[
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_1.png"; width: 640; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_1.png"; width: 640; height: 360 }
                level3: ListElement{ path: "images/background/walls/a.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_2.png"; width: 282; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_2.png"; width: 282; height: 360 }
                level3: ListElement{ path: "images/background/walls/b.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/c.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/d.png"; width: 603; height: 360 }
            }
        ]

        sprites:[
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/CeilingLightMedium.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/CeilingLightMedium.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/CeilingLightMedium.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/SmallChairComponent.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "ceiling/CeilingLightSmall.qml" },
                    ListElement{ componentpath: "ground/SmallDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/DeskComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BeanComponent.qml" }
                ]
            }
        ]
    }
    ListElement{
        lid: 2
        background:[
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_1.png"; width: 640; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_1.png"; width: 640; height: 360 }
                level3: ListElement{ path: "images/background/walls/a.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_2.png"; width: 282; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_2.png"; width: 282; height: 360 }
                level3: ListElement{ path: "images/background/walls/b.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/c.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/d.png"; width: 603; height: 360 }
            }
        ]

        sprites:[
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/CeilingLightBig.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/CeilingLightBig.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Medium.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/SmallChairComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/VeryBigDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/ComboSmallDeckBeanComponent.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "ceiling/CeilingLightSmall.qml" },
                    ListElement{ componentpath: "ground/BigDeckComponent.qml" }
                ]
            }
        ]
    }
    ListElement{
        lid: 3
        background:[
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_1.png"; width: 640; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_1.png"; width: 640; height: 360 }
                level3: ListElement{ path: "images/background/walls/a.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_2.png"; width: 282; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_2.png"; width: 282; height: 360 }
                level3: ListElement{ path: "images/background/walls/b.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/c.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/d.png"; width: 603; height: 360 }
            }
        ]

        sprites:[
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Big.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/CeilingLightBig.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BigChairComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/CeilingLightSmall.qml"},
                    ListElement{ componentpath: "ground/BigDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BigChairComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/ComboDeskSmallDeckComponent.qml" }
                ]
            }
        ]
    }
    ListElement{
        lid: 4
        background:[
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_1.png"; width: 640; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_1.png"; width: 640; height: 360 }
                level3: ListElement{ path: "images/background/walls/a.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_2.png"; width: 282; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_2.png"; width: 282; height: 360 }
                level3: ListElement{ path: "images/background/walls/b.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/c.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/d.png"; width: 603; height: 360 }
            }
        ]

        sprites:[
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BigDeckComponent.qml"},
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Medium.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/CeilingLightBig.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BeanComponent.qml" },
                    ListElement{ componentpath: "ceiling/CeilingLightMedium.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/CeilingLightBig.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/VeryBigDeckComponent.qml" }
                ]
            }
        ]
    }
    ListElement{
        lid: 5
        background:[
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_1.png"; width: 640; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_1.png"; width: 640; height: 360 }
                level3: ListElement{ path: "images/background/walls/a.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_2.png"; width: 282; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_2.png"; width: 282; height: 360 }
                level3: ListElement{ path: "images/background/walls/b.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/c.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/d.png"; width: 603; height: 360 }
            }
        ]

        sprites:[
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BigDeckComponent.qml"},
                    ListElement{ componentpath: "ceiling/CeilingLightMedium.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BigChairComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/ComboDeskSmallDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Big.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "ground/VeryBigDeckComponent.qml" },
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Small.qml" }
                ]
            }

        ]
    }
    ListElement{
        lid: 6
        background:[
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_1.png"; width: 640; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_1.png"; width: 640; height: 360 }
                level3: ListElement{ path: "images/background/walls/a.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_2.png"; width: 282; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_2.png"; width: 282; height: 360 }
                level3: ListElement{ path: "images/background/walls/b.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/c.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/d.png"; width: 603; height: 360 }
            }
        ]

        sprites:[
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Small.qml"},
                    ListElement{ componentpath: "ground/BigDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/ComboDeskSmallDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Big.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "ground/BeanComponent.qml" },
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Medium.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "ground/VeryBigDeckComponent.qml" },
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Small.qml" }
                ]
            }
        ]
    }
    ListElement{
        lid: 7
        background:[
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_1.png"; width: 640; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_1.png"; width: 640; height: 360 }
                level3: ListElement{ path: "images/background/walls/a.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_2.png"; width: 282; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_2.png"; width: 282; height: 360 }
                level3: ListElement{ path: "images/background/walls/b.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/c.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/d.png"; width: 603; height: 360 }
            }
        ]

        sprites:[
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BigDeckComponent.qml"},
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Medium.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/VeryBigDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Small.qml"},
                    ListElement{ componentpath: "ground/SmallDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/ComboDeskSmallDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/CeilingLightBig.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "ground/VeryBigDeckComponent.qml" },
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Small.qml" }
                ]
            }

        ]
    }
    ListElement{
        lid: 8
        background:[
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_1.png"; width: 640; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_1.png"; width: 640; height: 360 }
                level3: ListElement{ path: "images/background/walls/a.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_2.png"; width: 282; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_2.png"; width: 282; height: 360 }
                level3: ListElement{ path: "images/background/walls/b.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/c.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/d.png"; width: 603; height: 360 }
            }
        ]

        sprites:[
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BigDeckComponent.qml"},
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Medium.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/VeryBigDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/ComboDeskSmallDeckComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Big.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "ground/BeanComponent.qml" },
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Medium.qml" }
                ]
            },ListElement{
                items:[
                    ListElement{ componentpath: "balls/BasketBallComponent.qml" }
                ]
            }
        ]
    }
    ListElement{
        lid: 9
        background:[
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_1.png"; width: 640; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_1.png"; width: 640; height: 360 }
                level3: ListElement{ path: "images/background/walls/a.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_2.png"; width: 282; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_2.png"; width: 282; height: 360 }
                level3: ListElement{ path: "images/background/walls/b.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/c.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/d.png"; width: 603; height: 360 }
            }
        ]

        sprites:[
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BeanComponent.qml"},
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Medium.qml"}
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "balls/BasketBallComponent.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Big.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "balls/BasketBallComponent.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "ground/SmallDeckComponent.qml" },
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Big.qml" }
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/BigDeckComponent.qml"},
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Medium.qml"}
                ]
            }
        ]
    }
    ListElement{
        lid: 10
        background:[
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_1.png"; width: 640; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_1.png"; width: 640; height: 360 }
                level3: ListElement{ path: "images/background/walls/a.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ListElement{ path: "images/background/outdoors/sky_2.png"; width: 282; height: 360 }
                level2: ListElement{ path: "images/background/outdoors/trees_2.png"; width: 282; height: 360 }
                level3: ListElement{ path: "images/background/walls/b.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/c.png"; width: 640; height: 360 }
            },
            ListElement{
                level1: ''
                level2: ''
                level3: ListElement{ path: "images/background/walls/d.png"; width: 603; height: 360 }
            }
        ]

        sprites:[
            ListElement{
                items: [
                    ListElement{ componentpath: "ground/SmallDeckComponent.qml"},
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Big.qml"}
                ]
            },
            ListElement{
                items: [
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Big.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "balls/BasketBallComponent.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "balls/BasketBallComponent.qml" }
                ]
            },
            ListElement{
                items:[
                    ListElement{ componentpath: "ground/BeanComponent.qml" },
                    ListElement{ componentpath: "ceiling/MovingCeilingLight_Medium.qml" }
                ]
            }

        ]
    }
}
