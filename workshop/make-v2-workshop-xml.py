"""Generate the v2.0 Steam Workshop task XMLs.

- WorkshopRetire-<Key>.xml  : updates ModReady's four old dependency items to the
                              "retired" notice module + description.
- WorkshopCreate-ModReady.xml: creates the new single ModReady add-on item.

Run: python make-v2-workshop-xml.py   (writes next to this script)
"""
from pathlib import Path
from xml.sax.saxutils import quoteattr

HERE = Path(__file__).resolve().parent
DIST = r"C:\dev\modready\framework\dist\v2"
NEXUS = "https://www.nexusmods.com/mountandblade2bannerlord/mods/11274"
GITHUB = "https://github.com/Trashpanda62/modready-framework"
VERSIONS = ["v1.4.0", "v1.4.1", "v1.4.2", "v1.4.3", "v1.4.4", "v1.4.5", "v1.4.6", "v1.4.7", "v1.4.8"]

# Our old item id, folder key, BUTR item id, display name
RETIRED = [
    ("3747619959", "Harmony", "2859188632", "Harmony", "ModReady-Harmony-thumb.png"),
    ("3747620095", "UIExtenderEx", "2859222409", "UIExtenderEx", "ModReady-UIExtenderEx-thumb.png"),
    ("3747620149", "ButterLib", "2859232415", "ButterLib", "ModReady-ButterLib-thumb.png"),
    ("3747620191", "MCM", "2859238197", "Mod Configuration Menu v5", "ModReady-MCM-thumb.png"),
]

BUTR_LIST = (
    "[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2859188632]Harmony[/url] · "
    "[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2859222409]UIExtenderEx[/url] · "
    "[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2859232415]ButterLib[/url] · "
    "[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2859238197]Mod Configuration Menu v5[/url]"
)


def tags(extra=()):
    vals = ["Utility", "Native", "Singleplayer", *extra, *VERSIONS]
    return "\n".join(f'            <Tag Value="{v}" />' for v in vals)


def write(name, body):
    (HERE / name).write_text(body, encoding="utf-8")
    print("wrote", name)


for item_id, key, butr_id, display, thumb in RETIRED:
    desc = (
        f"[b]RETIRED — please unsubscribe.[/b]&#10;&#10;"
        f"This item used to hold ModReady's own build of {display}. ModReady no longer ships its own copies of the "
        f"BUTR dependency modules: BUTR's originals are updated for Bannerlord v1.4.8, and running two sets with the "
        f"same module IDs was causing crashes.&#10;&#10;"
        f"[b]What to do:[/b] unsubscribe from this item and subscribe to BUTR's original "
        f"[url=https://steamcommunity.com/sharedfiles/filedetails/?id={butr_id}]{display}[/url]. "
        f"Full BUTR stack: {BUTR_LIST}.&#10;&#10;"
        f"ModReady itself lives on as an optional add-on (save-load and crash guards) that runs on top of BUTR's stack: "
        f"[url={NEXUS}]Nexus[/url] · [url={GITHUB}]source[/url]."
    )
    notes = (
        "Retired. ModReady no longer ships its own Harmony/UIExtenderEx/ButterLib/MCM. "
        "Unsubscribe and use BUTR's originals (linked in the description), which support v1.4.8."
    )
    write(f"WorkshopRetire-{key}.xml", f"""<Tasks>
    <GetItem>
        <ItemId Value="{item_id}"/>
    </GetItem>
    <UpdateItem>
        <ModuleFolder Value="{DIST}\\Retired\\ModReadyRetired.{key}"/>
        <ItemDescription Value={quoteattr(desc).replace('&amp;#10;', '&#10;')}/>
        <ChangeNotes Value={quoteattr(notes)} />
        <Image Value="C:\\dev\\modready\\workshop\\{thumb}"/>
        <Visibility Value="Public"/>
        <Tags>
{tags()}
        </Tags>
    </UpdateItem>
</Tasks>
""")

create_desc = (
    "[b]ModReady[/b] — save-load and crash guards for Bannerlord, as an optional add-on that runs on top of BUTR's "
    "dependency stack.&#10;&#10;"
    "[b]What it does[/b]&#10;"
    "- Removes corrupt leftover troops (e.g. orphaned retinues) from party rosters on load, so the map and party screens stop freezing&#10;"
    "- Guards the tooltip text lookup and map-bar refresh so a broken mod can't hang the campaign map on load&#10;"
    "- Fixes the main-menu Continue save-load loop with mismatched modules&#10;"
    "- Loads mods that ship several per-game-version DLLs without corrupting the save system&#10;"
    "- Catches mod patches built against older game versions and names the culprit mod in runtime.log&#10;&#10;"
    f"[b]Requires[/b] BUTR's {BUTR_LIST.split(' · ')[0]}. Load order: Harmony, then ModReady, then your other mods.&#10;&#10;"
    "ModReady no longer ships its own Harmony/UIExtenderEx/ButterLib/MCM — use BUTR's originals. "
    "If you were subscribed to the old ModReady dependency items, unsubscribe from them.&#10;&#10;"
    f"[url={NEXUS}]Nexus[/url] · [url={GITHUB}]Source (MIT)[/url] · "
    "[url=https://www.patreon.com/Trashpanda62?utm_source=steam]Patreon[/url]"
)
write("WorkshopCreate-ModReady.xml", f"""<Tasks>
    <CreateItem/>
    <UpdateItem>
        <ModuleFolder Value="{DIST}\\Modules\\ModReady"/>
        <ItemDescription Value={quoteattr(create_desc).replace('&amp;#10;', '&#10;')}/>
        <Image Value="C:\\dev\\modready\\workshop\\ModReady-Image.png"/>
        <Visibility Value="Public"/>
        <Tags>
{tags()}
        </Tags>
    </UpdateItem>
</Tasks>
""")
