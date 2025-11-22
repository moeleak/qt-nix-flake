#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>

class Backend : public QObject {
  Q_OBJECT
  Q_PROPERTY(QString windowTitle READ windowTitle CONSTANT)
  Q_PROPERTY(QString statusText READ statusText NOTIFY statusTextChanged)
  Q_PROPERTY(
      QString buttonLabel READ buttonLabel WRITE setButtonLabel NOTIFY buttonLabelChanged)
  Q_PROPERTY(
      int sliderValue READ sliderValue WRITE setSliderValue NOTIFY sliderValueChanged)
  Q_PROPERTY(bool featureEnabled READ featureEnabled WRITE setFeatureEnabled NOTIFY
                 featureEnabledChanged)
  Q_PROPERTY(int comboIndex READ comboIndex WRITE setComboIndex NOTIFY comboIndexChanged)
  Q_PROPERTY(QString inputText READ inputText WRITE setInputText NOTIFY inputTextChanged)

public:
  explicit Backend(QObject *parent = nullptr);

  QString windowTitle() const;
  QString statusText() const;
  QString buttonLabel() const;
  int sliderValue() const;
  bool featureEnabled() const;
  int comboIndex() const;
  QString inputText() const;

  void setButtonLabel(const QString &label);
  void setSliderValue(int value);
  void setFeatureEnabled(bool enabled);
  void setComboIndex(int index);
  void setInputText(const QString &text);

  Q_INVOKABLE void handleButtonClicked();

signals:
  void statusTextChanged();
  void buttonLabelChanged();
  void sliderValueChanged();
  void featureEnabledChanged();
  void comboIndexChanged();
  void inputTextChanged();

private:
  void updateStatusText();

  QString m_windowTitle;
  QString m_statusText;
  QString m_buttonLabel;
  int m_sliderValue;
  bool m_featureEnabled;
  int m_comboIndex;
  QString m_inputText;
};

#endif // BACKEND_H
