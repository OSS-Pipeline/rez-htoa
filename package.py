name = "htoa"

version = "4.3.0"

authors = [
    "Solid Angle",
    "Autodesk"
]

description = \
    """
    HtoA is a plug-in for SideFX Houdini which allows you to use the Arnold renderer directly in Houdini.
    """

requires = [
    "cmake-3+",
    "houdini-17.5.360"
]

variants = [
    ["platform-linux"]
]

build_system = "cmake"

with scope("config") as config:
    config.build_thread_count = "logical_cores"

uuid = "htoa-{version}".format(version=str(version))

def commands():
    env.HOUDINI_PATH.prepend("{root}")
    env.HTOA.set("{root}")

    # Helper environment variables.
    env.HTOA_LIBRARY_PATH.set("{root}/dso")
