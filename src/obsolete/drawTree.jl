module drawTree

using VegaLite

export drawtree

function drawtree(asd)
    
    @vgplot(
        height=800,
        padding=1,
        marks=[
            {
                encode={
                    update={
                        stroke={
                            value="#ccc"
                        },
                        path={
                            field="path"
                        }
                    }
                },
                from={
                    data="links"
                },
                type="path"
            },
            {
                encode={
                    update={
                        x={
                            field="x"
                        },
                        fill={
                            field="depth",
                            scale="color"
                        },
                        y={
                            field="y"
                        }
                    },
                    enter={
                        stroke={
                            value="#fff"
                        },
                        size={
                            value=100
                        }
                    }
                },
                from={
                    data="tree"
                },
                type="symbol"
            },
            {
                encode={
                    update={
                        align={
                            signal="datum.children ? 'right' : 'left'"
                        },
                        x={
                            field="x"
                        },
                        dx={
                            signal="datum.children ? -7 : 7"
                        },
                        opacity={
                            signal="labels ? 1 : 0"
                        },
                        y={
                            field="y"
                        }
                    },
                    enter={
                        fontSize={
                            value=9
                        },
                        text={
                            field="name"
                        },
                        baseline={
                            value="middle"
                        }
                    }
                },
                from={
                    data="tree"
                },
                type="text"
            }
        ],
        data=[
            {
                name="tree",
                values=asd,
                transform=[
                    {
                        key="id",
                        parentKey="parent",
                        type="stratify"
                    },
                    {
                        method={
                            signal="layout"
                        },
                        separation={
                            signal="separation"
                        },
                        as=[
                            "y",
                            "x",
                            "depth",
                            "children"
                        ],
                        size=[
                            {
                                signal="height"
                            },
                            {
                                signal="width - 100"
                            }
                        ],
                        type="tree"
                    }
                ]
            },
            {
                name="links",
                source="tree",
                transform=[
                    {
                        type="treelinks"
                    },
                    {
                        shape={
                            signal="links"
                        },
                        type="linkpath",
                        orient="horizontal"
                    }
                ]
            }
        ],
        scales=[
            {
                name="color",
                zero=true,
                range={
                    scheme="magma"
                },
                domain={
                    data="tree",
                    field="depth"
                },
                type="linear"
            }
        ],
        width=600,
        signals=[
            {
                name="labels",
                bind={
                    input="checkbox"
                },
                value=true
            },
            {
                name="layout",
                bind={
                    options=[
                        "tidy",
                        "cluster"
                    ],
                    input="radio"
                },
                value="tidy"
            },
            {
                name="links",
                bind={
                    options=[
                        "line",
                        "curve",
                        "diagonal",
                        "orthogonal"
                    ],
                    input="select"
                },
                value="orthogonal"
            },
            {
                name="separation",
                bind={
                    input="checkbox"
                },
                value=true
            }
        ]
    )
end

end