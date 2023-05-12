def predict_delay(departure_date_time, origin, destination):\n    from datetime import datetime\n\n    try:\n        departure_date_time_parsed = datetime.strptime(departure_date_time, '%d/%m/%Y %H:%M:%S')\n    except ValueError as e:\n        return 'Error parsing date/time - {}'.format(e)\n\n    month = departure_date_time_parsed.month\n    day = departure_date_time_parsed.day\n    day_of_week = departure_date_time_parsed.isoweekday()\n    hour = departure_date_time_parsed.hour\n\n    origin = origin.upper()\n    destination = destination.upper()\n\n    input = [{'MONTH': month,\n              'DAY': day,\n              'DAY_OF_WEEK': day_of_week,\n              'CRS_DEP_TIME': hour,\n              'ORIGIN_ATL': 1 if origin == 'ATL' else 0,\n              'ORIGIN_DTW': 1 if origin == 'DTW' else 0,\n              'ORIGIN_JFK': 1 if origin == 'JFK' else 0,\n              'ORIGIN_MSP': 1 if origin == 'MSP' else 0,\n              'ORIGIN_SEA': 1 if origin == 'SEA' else 0,\n              'DEST_ATL': 1 if destination == 'ATL' else 0,\n              'DEST_DTW': 1 if destination == 'DTW' else 0,\n              'DEST_JFK': 1 if destination == 'JFK' else 0,\n              'DEST_MSP': 1 if destination == 'MSP' else 0,\n              'DEST_SEA': 1 if destination == 'SEA' else 0 }]\n\n    return model.predict_proba(pd.DataFrame(input))[0][0]