# モジュールのインポート
import xml.etree.ElementTree as ET
import csv

arr = []

# xmlファイルの読み込み
tree = ET.parse('/content/change.xml')

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
#     'measure' : 1,
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
    for index_note, note in enumerate(measure.iter('note')):
      print('　ノート:')
      print('　　duration:' + note.findtext('duration'))
      if note.findall('rest'):
        print("　　分類:休符")
        notes.append(dict([
          ("measure",measure.attrib['number']),
          ("type", "休符"),
          ("duration", str(note.findtext('duration'))),
          ("pitch", dict([('step', 0),
            ('octave', 0)
          ]))
        ]))
      elif note.findall('chord'):
        for pitch in note.iter('pitch'):
          print('　　pitch:(step:' + pitch.findtext('step') + ', octave:' + pitch.findtext('octave') + ")")
          notes.append(dict([
            ("measure",measure.attrib['number']),
            ("type", "和音"),
            ("duration", str(note.findtext('duration'))),
            ("pitch", dict([('step', pitch.findtext('step')),
              ('octave', pitch.findtext('octave'))
            ]))
          ]))
      else: 
        for pitch in note.iter('pitch'):
          print('　　pitch:(step:' + pitch.findtext('step') + ', octave:' + pitch.findtext('octave') + ")")
          notes.append(dict([
            ("measure",measure.attrib['number']),
            ("type", "単音"),
            ("duration", str(note.findtext('duration'))),
            ("pitch", dict([('step', pitch.findtext('step')),
              ('octave', pitch.findtext('octave'))
            ])
          )]))
          print("　　分類:単音")
          print('　　type:' + note.findtext('type'))
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

# 次の拍までは全拍の速度で再生＝＞デトロイトのピアノみたいなやつ

csvData = []


def format_chord(str):#どこに合わせるか知らんから数字と英語の対応は適当
    val = ""
    if str == "A":
        val = 6
    elif str == "B":
        val = 7
    elif str == "C":
        val = 1
    elif str == "D":
        val = 2
    elif str == "E":
        val = 3
    elif str == "F":
        val = 4
    elif str == "G":
        val = 5
    elif str == 0:
        val = 0
    return val


for note in notes:
    csvData.append([
        format_chord(note['pitch']['step']),
        note['pitch']['octave'],
        note['duration'],
        note['measure']
    ])

with open('./result.csv', 'w',newline="") as f:
    writer = csv.writer(f)
    writer.writerows(csvData)


# print(csvData)