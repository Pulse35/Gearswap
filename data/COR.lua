-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Ranged', 'Melee', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

    gear.RAbullet = "Corsair Bullet"
    gear.WSbullet = "Steel Bullet"
    gear.MAbullet = "Steel Bullet"
    gear.QDbullet = "Steel Bullet"
    options.ammo_warning_limit = 15

    -- Additional local binds
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Snake Eye" <me>')

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
        
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    
    sets.precast.CorsairShot = {head="Blood Mask"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = sets.engaged.Melee


    sets.precast.RA = {ammo=gear.RAbullet,
    head="Corsair's Tricorne", neck="Qiqirn Collar", lear="Pennon Earring +1", rear="Vision Earring",
    body="Corsair's Frac", hands="Commodore Gants", ring1="Behemoth Ring +1", ring2="Behemoth Ring +1",
    back="Amemet Mantle +1", waist="Volant Belt", legs="Dusk Trousers +1", feet="War Boots +1"}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = { neck=gear.ElementalGorget }


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = sets.precast.WS

    sets.precast.WS['Slug Shot'] = {ammo=gear.RAbullet,
    head="Corsair's Tricorne", lear="Pennon Earring +1", rear="Vision Earring",
    body="Corsair's Frac", hands="Blood Fng. Gnt.", ring1="Triumph Ring +1", ring2="Triumph Ring +1",
    back="Amemet Mantle +1", waist="Volant Belt", legs="Dusk Trousers +1", feet="War Boots +1"}    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {ammo=gear.QDbullet,
    head="Corsair's Tricorne", neck="Caract Choker", lear="Pennon Earring +1", rear="Crapaud Earring",
    body="Antares harness", hands="Blood Fng. Gnt.", ring1="Nimble Ring +1", ring2="Nimble Ring +1",
    back="Commander's Cape", waist="Commodore's Belt", legs="Oily Trousers", feet="Winged Boots +1"}

    sets.midcast.CorsairShot.Acc = {ammo=gear.QDbullet,
    head="Corsair's Tricorne", neck="Caract Choker", lear="Incubus Earring +1", rear="Incubus Earring +1",
    body="Antares harness", hands="Blood Fng. Gnt.", ring1="Nimble Ring +1", ring2="Nimble Ring +1",
    back="Commander's Cape", waist="Commodore's Belt", legs="Oily Trousers", feet="Winged Boots +1"}

    sets.midcast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
    head="Corsair's Tricorne", neck="", lear="Incubus Earring +1", rear="Incubus Earring +1",
    body="Antares harness", hands="Blood Fng. Gnt.", ring1="Nimble Ring +1", ring2="Nimble Ring +1",
    back="Commander's Cape", waist="Commodore's Belt", legs="Oily Trousers", feet="Winged Boots +1"}

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']


    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
    head="Corsair's Tricorne", neck="Qiqirn Collar", lear="Pennon Earring +1", rear="Vision Earring",
    body="Corsair's Frac", hands="Blood Fng. Gnt.", ring1="Behemoth Ring +1", ring2="Behemoth Ring +1",
    back="Amemet Mantle +1", waist="Commodore's Belt", legs="Dusk Trousers +1", feet="War Boots +1"}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
    head="Corsair's Tricorne", neck="Qiqirn Collar", lear="Pennon Earring +1", rear="Vision Earring",
    body="Corsair's Frac", hands="Blood Fng. Gnt.", ring1="Behemoth Ring +1", ring2="Behemoth Ring +1",
    back="Amemet Mantle +1", waist="Commodore's Belt", legs="Dusk Trousers +1", feet="War Boots +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
    head="Blood Mask", neck="Orochi Nodowa +1", hands="Feronia's bangles"}
    

    -- Idle sets
    sets.idle = {ammo=gear.RAbullet,
    head="Blood Mask", neck="Orochi Nodowa +1", lear="Merman's Earring", rear="Merman's Earring",
    body="Commodore Frac", hands="Denali Wristbands", back="Lamia Mantle +1", waist="Resolute Belt",
    legs="Blood Cuisses", feet="Hermes' Sandals +1", ring1="Merman's Ring", ring2="Merman's Ring"}

    sets.idle.Town = {ammo=gear.RAbullet,
    head="Blood Mask", neck="Orochi Nodowa +1", lear="Merman's Earring", rear="Merman's Earring",
    body="Commodore Frac", hands="Denali Wristbands", back="Lamia Mantle +1", waist="Resolute Belt",
    legs="Blood Cuisses", feet="Hermes' Sandals +1", ring1="Merman's Ring", ring2="Merman's Ring"}
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}
    

    sets.Kiting = {feet="Hermes' Sandals +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged.Melee = {ammo=gear.RAbullet,
    head="Walahra Turban", neck="Peacock Amulet", lear="Suppanomimi", rear="Brutal Earring",
    body="Antares Harness", hands="Dusk Gloves +1", ring1="Toreador's Ring", ring2="Rajas Ring",
    back="Amemet Mantle +1", waist="Velocious Belt", legs="Dusk Trousers +1", feet="Dusk Ledelsens +1"}
    
    sets.engaged.Acc = {ammo=gear.RAbullet,
    head="Walahra Turban", neck="Peacock Amulet", lear="Suppanomimi", rear="Brutal Earring",
    body="Antares Harness", hands="Dusk Gloves +1", ring1="Toreador's Ring", ring2="Rajas Ring",
    back="Cuchulain's Mantle", waist="Velocious Belt", legs="Oily Trousers", feet="Dusk Ledelsens +1"}

    sets.engaged.Melee.DW = {ammo=gear.RAbullet,
    head="Walahra Turban", neck="Peacock Amulet", lear="Suppanomimi", rear="Brutal Earring",
    body="Antares Harness", hands="Dusk Gloves +1", ring1="Toreador's Ring", ring2="Rajas Ring",
    back="Amemet Mantle +1", waist="Velocious Belt", legs="Oily Trousers", feet="Dusk Ledelsens +1"}
    
    sets.engaged.Acc.DW = {ammo=gear.RAbullet,
    head="Walahra Turban", neck="Peacock Amulet", lear="Suppanomimi", rear="Brutal Earring",
    body="Antares Harness", hands="Dusk Gloves +1", ring1="Toreador's Ring", ring2="Rajas Ring",
    back="Amemet Mantle +1", waist="Velocious Belt", legs="Oily Trousers", feet="Dusk Ledelsens +1"}


    sets.engaged.Ranged = {ammo=gear.RAbullet,
    head="Walahra Turban", neck="Peacock Amulet", lear="Suppanomimi", rear="Merman's Earring",
    body="Antares Harness", hands="Dusk Gloves +1", ring1="Toreador's Ring", ring2="Rajas Ring",
    back="Amemet Mantle +1", waist="Velocious Belt", legs="Dusk Trousers +1", feet="Dusk Ledelsens +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 17)
end

