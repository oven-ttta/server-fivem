Config = {}

Config.Locale = 'th'

-- กลุ่มที่มีสิทธิ์ใช้คำสั่งแอดมิน
Config.AdminGroups = {
    'admin',
    'superadmin',
    'owner'
}

-- คำสั่งแอดมิน
Config.Commands = {
    teleport = {
        name = 'tp',
        help = 'วาร์ปไปหาผู้เล่น',
        params = {{name = 'id', help = 'ID ผู้เล่น'}},
        group = 'admin'
    },
    teleportToCoords = {
        name = 'tpm',
        help = 'วาร์ปไปที่เครื่องหมายบนแผนที่',
        group = 'admin'
    },
    revive = {
        name = 'revive',
        help = 'ชุบชีวิตผู้เล่น',
        params = {{name = 'id', help = 'ID ผู้เล่น (เว้นว่างสำหรับตัวเอง)'}},
        group = 'admin'
    },
    heal = {
        name = 'heal',
        help = 'รักษาผู้เล่น',
        params = {{name = 'id', help = 'ID ผู้เล่น'}},
        group = 'admin'
    },
    giveItem = {
        name = 'giveitem',
        help = 'ให้ไอเทม',
        params = {
            {name = 'id', help = 'ID ผู้เล่น'},
            {name = 'item', help = 'ชื่อไอเทม'},
            {name = 'count', help = 'จำนวน'}
        },
        group = 'admin'
    },
    giveMoney = {
        name = 'givemoney',
        help = 'ให้เงิน',
        params = {
            {name = 'id', help = 'ID ผู้เล่น'},
            {name = 'account', help = 'bank/money/black_money'},
            {name = 'amount', help = 'จำนวน'}
        },
        group = 'admin'
    },
    setJob = {
        name = 'setjob',
        help = 'ตั้งงานให้ผู้เล่น',
        params = {
            {name = 'id', help = 'ID ผู้เล่น'},
            {name = 'job', help = 'ชื่องาน'},
            {name = 'grade', help = 'เกรด'}
        },
        group = 'admin'
    },
    freeze = {
        name = 'freeze',
        help = 'แช่แข็งผู้เล่น',
        params = {{name = 'id', help = 'ID ผู้เล่น'}},
        group = 'admin'
    },
    unfreeze = {
        name = 'unfreeze',
        help = 'ปลดแช่แข็งผู้เล่น',
        params = {{name = 'id', help = 'ID ผู้เล่น'}},
        group = 'admin'
    },
    kick = {
        name = 'kick',
        help = 'เตะผู้เล่นออก',
        params = {
            {name = 'id', help = 'ID ผู้เล่น'},
            {name = 'reason', help = 'เหตุผล'}
        },
        group = 'admin'
    },
    ban = {
        name = 'ban',
        help = 'แบนผู้เล่น',
        params = {
            {name = 'id', help = 'ID ผู้เล่น'},
            {name = 'days', help = 'จำนวนวัน (0 = ถาวร)'},
            {name = 'reason', help = 'เหตุผล'}
        },
        group = 'superadmin'
    },
    unban = {
        name = 'unban',
        help = 'ปลดแบนผู้เล่น',
        params = {{name = 'identifier', help = 'Identifier ผู้เล่น'}},
        group = 'superadmin'
    },
    noclip = {
        name = 'noclip',
        help = 'เปิด/ปิด Noclip',
        group = 'admin'
    },
    spawnVehicle = {
        name = 'car',
        help = 'สร้างรถ',
        params = {{name = 'model', help = 'ชื่อรถ'}},
        group = 'admin'
    },
    deleteVehicle = {
        name = 'dv',
        help = 'ลบรถ',
        group = 'admin'
    },
    announce = {
        name = 'announce',
        help = 'ประกาศทั้งเซิร์ฟเวอร์',
        params = {{name = 'message', help = 'ข้อความ'}},
        group = 'admin'
    },
    spectate = {
        name = 'spectate',
        help = 'สังเกตการณ์ผู้เล่น',
        params = {{name = 'id', help = 'ID ผู้เล่น'}},
        group = 'admin'
    },
    coords = {
        name = 'coords',
        help = 'แสดงพิกัดปัจจุบัน',
        group = 'admin'
    },
    saveCoords = {
        name = 'savecoords',
        help = 'บันทึกพิกัดปัจจุบัน',
        params = {{name = 'name', help = 'ชื่อที่ต้องการบันทึก'}},
        group = 'admin'
    }
}

-- Discord Webhook สำหรับ Logs
Config.Webhooks = {
    admin = '',  -- ใส่ Webhook URL สำหรับ Admin Logs
    chat = '',   -- ใส่ Webhook URL สำหรับ Chat Logs
    money = '',  -- ใส่ Webhook URL สำหรับ Money Logs
    death = '',  -- ใส่ Webhook URL สำหรับ Death Logs
    job = ''     -- ใส่ Webhook URL สำหรับ Job Logs
}

-- สี Discord Embed
Config.Colors = {
    green = 65280,
    red = 16711680,
    yellow = 16776960,
    blue = 255,
    orange = 16753920
}
