# use the `mongo` image
# copy the app directory and any files needed for your implementation from your local to the container
# equip it with all the packages and installs needed to run the flask app (packages are defined in app/requirements.txt. `pip install -r app/requirements.txt`)
# expose the port flask app will run on

FROM python
COPY app /app/
#RUN apt-get update
#RUN apt-get install python3
#RUN apt-get install pip3
#RUN pip3 install flask
#RUN pip3 install pymongo
WORKDIR /app/
RUN pip3 install -r ./requirements.txt
EXPOSE 5001

CMD [ "python3", "app.py" ]
