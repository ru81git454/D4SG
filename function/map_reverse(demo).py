import pandas as pd
import googlemaps
import json
import numpy as np

gmaps = googlemaps.Client(key='AIzaSyDlRya-P9x7YQnuVM3Jw022W4IkV6W-JHA')
def reverse_geocode(x):
    try:
        reverse_geocode_result = gmaps.reverse_geocode((x.latitude,x.longitude),language='zh-TW')
        long_name = np.nan
        address_components = reverse_geocode_result[0]['address_components']
        for component in address_components:
            if set(['administrative_area_level_3', 'political']) == set(component['types']):
                long_name = component['long_name']
        return reverse_geocode_result[0]['formatted_address'],long_name
    except:
        return np.nan,np.nan

def map_reverse(path):
    airbox_data=pd.read_csv(path)
    airbox_data['township'] = np.nan
    airbox_data['full_address'] = np.nan
    for idx,row in airbox_data.iterrows():
        formatted_address,long_name = reverse_geocode(row)
        airbox_data.loc[idx, 'full_address'] = formatted_address
        airbox_data.loc[idx, 'township'] = long_name
    airbox_data.to_csv('airbox.township.csv')

#example
map_reverse('./airbox.byTownship.csv')
