import numpy as np\n\nlabels = ('9:00', '12:00', '15:00', '18:00', '21:00', '23:00')\nvalues = (predict_delay('30/01/2020 09:00:00', 'SEA ', 'ATL  '),\n          predict_delay('30/01/2020 12:00:00', 'SEA ', 'ATL  '),\n          predict_delay('30/01/2020 15:00:00', 'SEA ', 'ATL  '),\n          predict_delay('30/01/2020 18:00:00', 'SEA ', 'ATL  '),\n          predict_delay('30/01/2020 21:00:00', 'SEA ', 'ATL  '),\n          predict_delay('30/01/2020 23:00:00', 'SEA ', 'ATL  '),\nalabels = np.arange(len(labels))\n\nplt.bar(alabels, values, align='center', alpha=0.5, color = \"blue\")\nplt.xticks(alabels, labels)\nplt.ylabel('Probability of On-Time Arrival')\nplt.ylim((0.0, 1.0))