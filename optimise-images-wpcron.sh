#! /bin/bash
########################################################################
# written by George Liu (eva2000) centminmod.com
# wrapper script to optimise-images.sh for
# batch optimise images for wordpress /upload directory via cronjob
# using optimise-images.sh optimise-cron-age or optimise-cron mode
# outlined at https://github.com/centminmod/optimise-images#unattended-subdirectory-runs
# 
# instructions set WPUPLOAD_DIR path to full path to your /wp-content/upload/
########################################################################
DT=$(date +"%d%m%y-%H%M%S")
VER='0.3'
DEBUG='n'
WEBP='y'

WPUPLOAD_DIR='/home/nginx/domains/domain.com/public/wp-content/upload'
WPUPLOAD_USER='nginx'
WPUPLOAD_GROUP='nginx'

OPTIMISE_IMAGESCRIPT='/root/tools/optimise-images/optimise-images.sh'
########################################################################

if [[ ! -d "$WPUPLOAD_DIR" ]]; then
  echo
  echo "Error WPUPLOAD_DIR defined at:"
  echo "$WPUPLOAD_DIR"
  echo "does not exist"
  exit
  echo
fi

webp_check() {
  if [[ "$WEBP" = [yY] ]]; then
    if [ -f "$OPTIMISE_IMAGESCRIPT" ]; then
      sed -i "s|IMAGICK_WEBP='n'|IMAGICK_WEBP='y'|" "$OPTIMISE_IMAGESCRIPT"
    fi
  else
    if [ -f "$OPTIMISE_IMAGESCRIPT" ]; then
      sed -i "s|IMAGICK_WEBP='y'|IMAGICK_WEBP='n'|" "$OPTIMISE_IMAGESCRIPT"
    fi
  fi
}

cron_run() {
  monthly=$1
  webp_check
  MONTH="$(date +"%Y\/%m")"
  if [[ "$monthly" = 'monthly' ]]; then
    WPUPLOAD_DIRLIST=$(find "$WPUPLOAD_DIR" -maxdepth 2 -mindepth 2 -type d -type d \( ! -wholename "$WPUPLOAD_DIR" \) | grep -E '[0-9]{4}' | grep $MONTH | sort)
  else
    WPUPLOAD_DIRLIST=$(find "$WPUPLOAD_DIR" -maxdepth 2 -mindepth 2 -type d -type d \( ! -wholename "$WPUPLOAD_DIR" \) | grep -E '[0-9]{4}' | sort)
  fi
  echo "$WPUPLOAD_DIRLIST" | while read d; 
  do
    if [[ "$(ls -Al $d | head -n1 | grep -o 'total 0')" != 'total 0' ]]; then
      echo "optimise directory: $d";
      echo "$OPTIMISE_IMAGESCRIPT optimise-cron $d";
      $OPTIMISE_IMAGESCRIPT optimise-cron $d;
      chown -R ${WPUPLOAD_USER}:${WPUPLOAD_GROUP} $d;
    else
      echo "skipping empty $d"
    fi
  done
  # chown -R ${WPUPLOAD_USER}:${WPUPLOAD_GROUP} "$WPUPLOAD_DIR"
}

cron_age() {
  monthly=$1
  webp_check
  MONTH="$(date +"%Y\/%m")"
  if [[ "$monthly" = 'monthly' ]]; then
    WPUPLOAD_DIRLIST=$(find "$WPUPLOAD_DIR" -maxdepth 2 -mindepth 2 -type d -type d \( ! -wholename "$WPUPLOAD_DIR" \) | grep -E '[0-9]{4}' | grep $MONTH | sort)
  else
    WPUPLOAD_DIRLIST=$(find "$WPUPLOAD_DIR" -maxdepth 2 -mindepth 2 -type d -type d \( ! -wholename "$WPUPLOAD_DIR" \) | grep -E '[0-9]{4}' | sort)
  fi
  echo "$WPUPLOAD_DIRLIST" | while read d; 
  do
    if [[ "$(ls -Al $d | head -n1 | grep -o 'total 0')" != 'total 0' ]]; then
      echo "optimise directory: $d";
      echo "$OPTIMISE_IMAGESCRIPT optimise-cron-age $d";
      $OPTIMISE_IMAGESCRIPT optimise-cron-age $d;
      chown -R ${WPUPLOAD_USER}:${WPUPLOAD_GROUP} $d;
    else
      echo "skipping empty $d"
    fi
  done
  # chown -R ${WPUPLOAD_USER}:${WPUPLOAD_GROUP} "$WPUPLOAD_DIR"
}

case "$1" in
  cron )
    cron_run
    ;;
  cron-age )
    cron_age
    ;;
  cron-monthly )
    cron_run monthly
    ;;
  cron-age-monthly )
    cron_age monthly
    ;;
  * )
    echo "Usage:"
    echo
    echo "$0 {cron|cron-age|cron-monthly|cron-age-monthly}"
    echo
    ;;
esac