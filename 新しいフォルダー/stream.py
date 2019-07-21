# モジュールのインポート
import xml.etree.ElementTree as ET

# xmlファイルの読み込み
# tree = ET.parse('in_the_hall_of_the_mountain_king.xml')
tree = ET.parse('lg-158147493.xml')
# tree = ET.parse('jinja.xml')

# XMLを取得
root = tree.getroot()

# 配列用意
# 和音はフォーマットしてから入れたい

measures = [{  # 曲データ配列
    'notes': [{  # ノーツ配列
        'type': '単音',  # ノーツタイプ(単音、和音、休符)
        'duration': 1,  # 長さ
        'pitch': [{  # 音程情報配列、和音の場合のみ複数入る、休符は空
            'step': 'C',
            'octave': 4,
        }]
    }]
}]

notes = []
# notes = [{  # ノーツ配列
#     'default-x': -1,
#     'type': '単音',  # ノーツタイプ(単音、和音、休符)
#     'duration': 1,  # 長さ
#     'pitch': [{  # 音程情報配列、和音の場合のみ複数入る、休符は空
#         'step': 'C',
#         'octave': 4,
#     }]
# }]

for part_index, part in enumerate(root.iter('part')):
    for index_measure, measure in enumerate(part.iter('measure')):

        print('小節:' + str(measure.attrib['number']))
        sum = 0
        temporaryX = 0
        for index_note, note in enumerate(measure.iter('note')):

            print('　ノート:')
            print('　　duration:' + note.findtext('duration'))

            if note.findall('rest'):
                print("　　分類:休符")
                # print(str(note.attrib['default-x']))#休符にはdefault-x指定がないっぽい？
                # print('　　type:' + note.findtext('type'))#休符にtypeは無い
                # temporaryX = -1  # default-xが無いので休符は特定の固定値
                notes.append(dict([("type", "休符"),
                                   ("duration", str(note.findtext('duration'))),
                                   ("pitch", dict([('step', ""),
                                                   ('octave', "")]))
                                   ]))

            # elif note.findall('chord'):
            #     print("　　分類:和音")
            #     print("    x座標:" + str(note.attrib['default-x']))
            #     print('　　type:' + note.findtext('type'))
            #     temporaryX = note.attrib['default-x']

            else:  # 休符でも和音でもない場合は単音とする
                # if temporaryX == note.attrib['default-x']:
                #     # print("chord")
                #
                #     for pitch in note.iter('pitch'):
                #         print()

                # else:
                for pitch in note.iter('pitch'):
                    # print('　　pitch:(step:' + pitch.findtext('step') + ', octave:' + pitch.findtext('octave') + ")")
                    notes.append(dict([("default-x", note.attrib['default-x']),
                                       ("type", "単音"),
                                       ("duration", str(note.findtext('duration'))),
                                       ("pitch", dict([('step', pitch.findtext('step')),
                                                       ('octave', pitch.findtext('octave'))]))]))

                print("　　分類:単音")
                print("    x座標:" + str(note.attrib['default-x']))
                print('　　type:' + note.findtext('type'))
                temporaryX = note.attrib['default-x']

            # for pitch in note.iter('pitch'):
            #     print('　　pitch:(step:' + pitch.findtext('step') + ', octave:' + pitch.findtext('octave') + ")")
            #
            #     notes.append(dict([("type", "単音"),
            #                        ("duration", str(note.findtext('duration'))),
            #                        ("pitch", dict([('step', pitch.findtext('step')),
            #                                        ('octave', pitch.findtext('octave'))]))]))

            sum += int(note.findtext('duration'))

        print("                 合計:" + str(sum))

# note内はchord/とrest/が入る時は場合分けする
# chord:和音
# rest:休符
# chordタグ直前の音も含む（default-xの値が一致した場合は和音）
# ＝＞連続かつx軸が同値なノーツ群を和音とする

# 和音によって合計値が増える

# duration/小節の合計値を一音の長さとすることで曲ごとに基準の違うdurationを均一化

# halfとか16thが二分音符とか十六分音符を表してそうだけど休符にないので無視

# 番号遡るの面倒だしx軸保存した配列作ったほうが早い

# むりくさ
from pip._vendor.distlib.compat import raw_input
from pythonosc import osc_message_builder
from pythonosc import udp_client

sender = udp_client.SimpleUDPClient('127.0.0.1', 4559)

input_test_word = raw_input('')

for index_nnn, nnn in enumerate(notes):
    input_test_word = raw_input('')
    if str(nnn['pitch']['step']):
        sender.send_message('/trigger/prophet', [str(nnn['pitch']['step']), 0.2])
    print(str(nnn['pitch']['step']))
    # print(str(nnn['pitch']))
    # print('a')
